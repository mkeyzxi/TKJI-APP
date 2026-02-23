import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/test_result.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  // Get database instance
  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'kebugaran.db');
    return await openDatabase(path, version: 1, onCreate: _createDb);
  }

  // Create database tables
  Future<void> _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE test_results(
        id TEXT PRIMARY KEY,
        namaParticipant TEXT NOT NULL,
        jenisKelamin TEXT NOT NULL,
        prodi TEXT NOT NULL,
        semester INTEGER NOT NULL,
        institusi TEXT NOT NULL,
        tinggiBadan REAL NOT NULL,
        beratBadan REAL NOT NULL,
        catatanKesehatan TEXT NOT NULL,
        lari60 REAL NOT NULL,
        gantung INTEGER NOT NULL,
        situp INTEGER NOT NULL,
        loncat INTEGER NOT NULL,
        lariJauh INTEGER NOT NULL,
        skorLari60 INTEGER NOT NULL,
        skorGantung INTEGER NOT NULL,
        skorSitup INTEGER NOT NULL,
        skorLoncat INTEGER NOT NULL,
        skorLariJauh INTEGER NOT NULL,
        totalSkor INTEGER NOT NULL,
        kategori TEXT NOT NULL,
        tanggalTes TEXT NOT NULL,
        createdAt TEXT NOT NULL,
        updatedAt TEXT NOT NULL
      )
    ''');

    // Create index untuk pencarian yang lebih cepat
    await db.execute('''
      CREATE INDEX idx_namaParticipant ON test_results(namaParticipant)
    ''');

    await db.execute('''
      CREATE INDEX idx_tanggalTes ON test_results(tanggalTes)
    ''');
  }

  // Insert test result
  Future<int> insertTestResult(TestResult result) async {
    try {
      final db = await database;
      return await db.insert(
        'test_results',
        result.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print('Error inserting test result: $e');
      rethrow;
    }
  }

  // Get all test results
  Future<List<TestResult>> getAllTestResults() async {
    try {
      final db = await database;
      final maps = await db.query('test_results', orderBy: 'tanggalTes DESC');

      return maps.isEmpty
          ? []
          : maps.map((map) => TestResult.fromMap(map)).toList();
    } catch (e) {
      print('Error getting all test results: $e');
      return [];
    }
  }

  // Get test result by ID
  Future<TestResult?> getTestResultById(String id) async {
    try {
      final db = await database;
      final maps = await db.query(
        'test_results',
        where: 'id = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return TestResult.fromMap(maps.first);
      }
      return null;
    } catch (e) {
      print('Error getting test result by ID: $e');
      return null;
    }
  }

  // Search test results by participant name
  Future<List<TestResult>> searchTestResultsByName(String name) async {
    try {
      final db = await database;
      final maps = await db.query(
        'test_results',
        where: 'namaParticipant LIKE ?',
        whereArgs: ['%$name%'],
        orderBy: 'tanggalTes DESC',
      );

      return maps.isEmpty
          ? []
          : maps.map((map) => TestResult.fromMap(map)).toList();
    } catch (e) {
      print('Error searching test results: $e');
      return [];
    }
  }

  // Get test results by date range
  Future<List<TestResult>> getTestResultsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final db = await database;
      final maps = await db.query(
        'test_results',
        where: 'tanggalTes >= ? AND tanggalTes <= ?',
        whereArgs: [startDate.toIso8601String(), endDate.toIso8601String()],
        orderBy: 'tanggalTes DESC',
      );

      return maps.isEmpty
          ? []
          : maps.map((map) => TestResult.fromMap(map)).toList();
    } catch (e) {
      print('Error getting test results by date range: $e');
      return [];
    }
  }

  // Update test result
  Future<int> updateTestResult(TestResult result) async {
    try {
      final db = await database;
      return await db.update(
        'test_results',
        result.toMap(),
        where: 'id = ?',
        whereArgs: [result.id],
      );
    } catch (e) {
      print('Error updating test result: $e');
      rethrow;
    }
  }

  // Delete test result by ID
  Future<int> deleteTestResult(String id) async {
    try {
      final db = await database;
      return await db.delete('test_results', where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      print('Error deleting test result: $e');
      rethrow;
    }
  }

  // Delete all test results
  Future<int> deleteAllTestResults() async {
    try {
      final db = await database;
      return await db.delete('test_results');
    } catch (e) {
      print('Error deleting all test results: $e');
      rethrow;
    }
  }

  // Get count of test results
  Future<int> getTestResultsCount() async {
    try {
      final db = await database;
      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM test_results',
      );
      return Sqflite.firstIntValue(result) ?? 0;
    } catch (e) {
      print('Error getting test results count: $e');
      return 0;
    }
  }

  // Close database
  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}
