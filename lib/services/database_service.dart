import 'package:klasifikasi_penyakit_sapi/models/app_models.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  DatabaseService._();

  static final DatabaseService instance = DatabaseService._();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _openDatabase();
    return _database!;
  }

  Future<Database> _openDatabase() async {
    final String databasePath = await getDatabasesPath();
    final String path = p.join(databasePath, 'diagnosis_sapi.db');

    return openDatabase(
      path,
      version: 1,
      onConfigure: (Database db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE cows (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            age INTEGER NOT NULL,
            gender TEXT NOT NULL,
            type TEXT NOT NULL
          )
        ''');

        await db.execute('''
          CREATE TABLE diagnosis_history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            date TEXT NOT NULL,
            cow_id INTEGER,
            cow_name TEXT NOT NULL,
            disease TEXT NOT NULL,
            confidence INTEGER NOT NULL,
            severity TEXT NOT NULL,
            recommendations TEXT NOT NULL,
            symptoms TEXT NOT NULL,
            FOREIGN KEY (cow_id)
              REFERENCES cows(id)
              ON DELETE SET NULL
          )
        ''');
      },
    );
  }

  Future<List<Cow>> getCows() async {
    final Database db = await database;

    final List<Map<String, Object?>> rows = await db.query(
      'cows',
      orderBy: 'name COLLATE NOCASE ASC',
    );

    return rows.map((row) => Cow.fromMap(row)).toList();
  }

  Future<Cow> insertCow(Cow cow) async {
    final Database db = await database;

    final int id = await db.insert(
      'cows',
      cow.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );

    return cow.copyWith(id: id);
  }

  Future<int> updateCow(Cow cow) async {
    if (cow.id == null) {
      throw ArgumentError('ID sapi tidak boleh null ketika memperbarui data.');
    }

    final Database db = await database;

    return db.update(
      'cows',
      cow.toMap(),
      where: 'id = ?',
      whereArgs: [cow.id],
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  Future<int> deleteCow(int id) async {
    final Database db = await database;

    return db.delete('cows', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<DiagnosisHistory>> getHistory() async {
    final Database db = await database;

    final List<Map<String, Object?>> rows = await db.query(
      'diagnosis_history',
      orderBy: 'date DESC',
    );

    return rows.map((row) => DiagnosisHistory.fromMap(row)).toList();
  }

  Future<DiagnosisHistory> insertHistory(DiagnosisHistory history) async {
    final Database db = await database;

    final int id = await db.insert(
      'diagnosis_history',
      history.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );

    return history.copyWith(id: id);
  }

  Future<int> deleteHistory(int id) async {
    final Database db = await database;

    return db.delete('diagnosis_history', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> countCows() async {
    final Database db = await database;

    final List<Map<String, Object?>> result = await db.rawQuery(
      'SELECT COUNT(*) AS total FROM cows',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<int> countHistory() async {
    final Database db = await database;

    final List<Map<String, Object?>> result = await db.rawQuery(
      'SELECT COUNT(*) AS total FROM diagnosis_history',
    );

    return Sqflite.firstIntValue(result) ?? 0;
  }

  Future<void> clearAllData() async {
    final Database db = await database;

    await db.transaction((Transaction txn) async {
      await txn.delete('diagnosis_history');
      await txn.delete('cows');
    });
  }

  Future<void> close() async {
    final Database? db = _database;

    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
