import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'database_helper.dart';
import '../models/test_result.dart';

class TestResultService {
  static const String _storageKey = 'test_results';
  static final DatabaseHelper _dbHelper = DatabaseHelper();

  // Save test result to SQLite
  static Future<void> saveTestResult(TestResult result) async {
    try {
      // Set timestamp jika belum ada
      if (result.createdAt == null) {
        result.createdAt = DateTime.now();
      }
      result.updatedAt = DateTime.now();

      await _dbHelper.insertTestResult(result);
    } catch (e) {
      print('Error saving test result: $e');
      rethrow;
    }
  }

  // Get all test results from SQLite
  static Future<List<TestResult>> getAllTestResults() async {
    try {
      return await _dbHelper.getAllTestResults();
    } catch (e) {
      print('Error getting test results: $e');
      return [];
    }
  }

  // Get test results by name
  static Future<List<TestResult>> getTestResultsByName(String name) async {
    try {
      return await _dbHelper.searchTestResultsByName(name);
    } catch (e) {
      print('Error filtering test results: $e');
      return [];
    }
  }

  // Get test result by ID
  static Future<TestResult?> getTestResultById(String id) async {
    try {
      return await _dbHelper.getTestResultById(id);
    } catch (e) {
      print('Error getting test result: $e');
      return null;
    }
  }

  // Delete test result
  static Future<void> deleteTestResult(String id) async {
    try {
      await _dbHelper.deleteTestResult(id);
    } catch (e) {
      print('Error deleting test result: $e');
      rethrow;
    }
  }

  // Clear all test results
  static Future<void> clearAllTestResults() async {
    try {
      await _dbHelper.deleteAllTestResults();
    } catch (e) {
      print('Error clearing test results: $e');
      rethrow;
    }
  }

  // Update test result
  static Future<void> updateTestResult(TestResult result) async {
    try {
      result.updatedAt = DateTime.now();
      await _dbHelper.updateTestResult(result);
    } catch (e) {
      print('Error updating test result: $e');
      rethrow;
    }
  }

  // Get test results count
  static Future<int> getTestResultsCount() async {
    try {
      return await _dbHelper.getTestResultsCount();
    } catch (e) {
      print('Error getting test results count: $e');
      return 0;
    }
  }

  // Get test results by date range
  static Future<List<TestResult>> getTestResultsByDateRange(
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      return await _dbHelper.getTestResultsByDateRange(startDate, endDate);
    } catch (e) {
      print('Error getting test results by date range: $e');
      return [];
    }
  }

  // Migration: Migrate data from SharedPreferences to SQLite
  static Future<void> migrateFromSharedPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(_storageKey) ?? [];

      if (jsonList.isEmpty) {
        print('No data to migrate from SharedPreferences');
        return;
      }

      print('Starting migration from SharedPreferences to SQLite...');
      int migrationCount = 0;

      for (String jsonString in jsonList) {
        try {
          final map = jsonDecode(jsonString) as Map<String, dynamic>;
          final result = TestResult.fromMap(map);

          // Ensure timestamps are set
          if (result.createdAt == null) {
            result.createdAt = DateTime.now();
          }
          result.updatedAt ??= DateTime.now();

          await _dbHelper.insertTestResult(result);
          migrationCount++;
        } catch (e) {
          print('Error migrating individual record: $e');
          continue; // Skip error records and continue
        }
      }

      print(
        'Migration completed. $migrationCount records migrated out of ${jsonList.length}',
      );

      // Clear SharedPreferences after successful migration
      await prefs.remove(_storageKey);
      print('SharedPreferences cleared.');
    } catch (e) {
      print('Error during migration: $e');
      rethrow;
    }
  }
}
