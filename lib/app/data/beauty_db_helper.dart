import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class BeautyDatabaseHelper {
  static final BeautyDatabaseHelper _instance =
      BeautyDatabaseHelper._internal();
  static Database? _database;

  factory BeautyDatabaseHelper() {
    return _instance;
  }

  BeautyDatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'beauty.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE beauty_items (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            description TEXT,
            media TEXT, 
            date TEXT
          )
        ''');
      },
    );
  }

  Future<int> insertItem(Map<String, dynamic> item) async {
    final db = await database;
    return await db.insert('beauty_items', item,
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getAllItems() async {
    final db = await database;
    return await db.query('beauty_items');
  }

  Future<int> updateItem(int id, Map<String, dynamic> item) async {
    final db = await database;
    return await db
        .update('beauty_items', item, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteItem(int id) async {
    final db = await database;
    return await db.delete('beauty_items', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteAll() async {
    final db = await database;
    return await db.delete('beauty_items');
  }

  Future<bool> isDailyRoutineCompleted() async {
    final db = await database;
    String today = DateTime.now()
        .toIso8601String()
        .split('T')[0]; // Extract only the date part

    List<Map<String, dynamic>> result = await db.query(
      'beauty_items',
      where: "date LIKE ?",
      whereArgs: ['$today%'], // Search for today's entries
    );

    return result.length == 5; // Ensure exactly 5 items are uploaded
  }

  Future<List<Map<String, dynamic>>> getTodayEntries() async {
    final db = await database;
    String today = DateTime.now()
        .toIso8601String()
        .split('T')[0]; // Extract only the date part

    return await db.query(
      'beauty_items',
      where: "date LIKE ?",
      whereArgs: ['$today%'], // Get records for today's date
      orderBy: 'date DESC',
    );
  }

  Future<int> getStreakCount() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT DISTINCT date(date) as entry_date FROM beauty_items
    GROUP BY entry_date
    HAVING COUNT(*) = 5
    ORDER BY entry_date DESC
  ''');

    if (results.isEmpty) return 0;

    int streak = 1;
    DateTime lastDate = DateTime.parse(results.first['entry_date']);

    for (int i = 1; i < results.length; i++) {
      DateTime currentDate = DateTime.parse(results[i]['entry_date']);
      if (lastDate.difference(currentDate).inDays == 1) {
        streak++;
        lastDate = currentDate;
      } else {
        break;
      }
    }

    return streak;
  }

  Future<double> getLast30DaysStreakPercentage() async {
    final db = await database;
    String today = DateTime.now().toIso8601String().split('T')[0];

    // Get data for the last 30 days including today
    List<Map<String, dynamic>> results = await db.rawQuery('''
    SELECT DISTINCT date(date) as entry_date 
    FROM beauty_items
    WHERE date(date) BETWEEN date(?, '-29 days') AND date(?)
    GROUP BY entry_date
    HAVING COUNT(*) = 5
  ''', [today, today]);

    int completedDays = results.length;

    // Calculate percentage based on available days (avoid division by zero)
    int totalDays = DateTime.now()
            .difference(DateTime.parse(
                results.isEmpty ? today : results.last['entry_date']))
            .inDays +
        1;
    double percentage = (completedDays / totalDays) * 100;

    return percentage;
  }
}
