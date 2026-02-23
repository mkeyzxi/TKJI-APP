import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'screens/splash_screen.dart';
import 'services/test_result_service.dart';
import 'services/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('id_ID', null);

  // Initialize database and migrate data from SharedPreferences
  try {
    final dbHelper = DatabaseHelper();
    await dbHelper.database; // Initialize database
    await TestResultService.migrateFromSharedPreferences(); // Migrate data
    print('Database initialized and migration completed');
  } catch (e) {
    print('Error during database initialization: $e');
  }

  runApp(TKJIApp());
}

class TKJIApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Kebugaran Jasmani - TKJI',
      theme: ThemeData(fontFamily: 'Poppins', useMaterial3: true),
      locale: Locale('id', 'ID'),
      supportedLocales: [Locale('id', 'ID'), Locale('en', 'US')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      home: SplashScreen(),
    );
  }
}
