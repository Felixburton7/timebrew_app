// // lib/data/data_sources/timer_database.dart
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:sqflite/sqlite_api.dart';

// class TimerDatabase {
//   static final TimerDatabase instance = TimerDatabase._init();

//   static Database? _database;

//   TimerDatabase._init();

//   Future<Database> get database async {
//     if (_database != null) return _database!;
//     _database = await _initDB('timer.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String filePath) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, filePath);
//     return await openDatabase(path, version: 1, onCreate: _createDB);
//   }

//   Future _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE timer_settings (
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         duration INTEGER NOT NULL
//       )
//     ''');
//   }
// }
// lib/data/data_sources/timer_database.dart

import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:final_timebrew_app/domain/entities/timer_setting.dart';

class TimerDatabase {
  static const String _boxName = 'timer_settings_box';

  static Future<void> init() async {
    // Register the adapter
    Hive.registerAdapter(TimerSettingAdapter());
    // Open the box if not already opened
    if (!Hive.isBoxOpen(_boxName)) {
      await Hive.openBox<TimerSetting>(_boxName);
    }
  }

  static Box<TimerSetting> get box => Hive.box<TimerSetting>(_boxName);
}
