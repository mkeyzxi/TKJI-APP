import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/test_result.dart';

class TestResultService {
  static const String _storageKey = 'test_results';

  // Save test result
  static Future<void> saveTestResult(TestResult result) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final results = await getAllTestResults();

      results.add(result);

      List<String> jsonList = results
          .map((r) => jsonEncode(r.toMap()))
          .toList();
      await prefs.setStringList(_storageKey, jsonList);
    } catch (e) {
      print('Error saving test result: $e');
    }
  }

  // Get all test results
  static Future<List<TestResult>> getAllTestResults() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonList = prefs.getStringList(_storageKey) ?? [];

      return jsonList
          .map((json) => TestResult.fromMap(jsonDecode(json)))
          .toList();
    } catch (e) {
      print('Error getting test results: $e');
      return [];
    }
  }

  // Get test results by name
  static Future<List<TestResult>> getTestResultsByName(String name) async {
    try {
      final allResults = await getAllTestResults();
      return allResults
          .where(
            (result) => result.namaParticipant.toLowerCase().contains(
              name.toLowerCase(),
            ),
          )
          .toList();
    } catch (e) {
      print('Error filtering test results: $e');
      return [];
    }
  }

  // Get test result by ID
  static Future<TestResult?> getTestResultById(String id) async {
    try {
      final allResults = await getAllTestResults();
      return allResults.firstWhere((result) => result.id == id);
    } catch (e) {
      print('Error getting test result: $e');
      return null;
    }
  }

  // Delete test result
  static Future<void> deleteTestResult(String id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final results = await getAllTestResults();

      results.removeWhere((result) => result.id == id);

      List<String> jsonList = results
          .map((r) => jsonEncode(r.toMap()))
          .toList();
      await prefs.setStringList(_storageKey, jsonList);
    } catch (e) {
      print('Error deleting test result: $e');
    }
  }

  // Clear all test results
  static Future<void> clearAllTestResults() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_storageKey);
    } catch (e) {
      print('Error clearing test results: $e');
    }
  }
}
