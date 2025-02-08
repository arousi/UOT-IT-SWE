import 'dart:developer';

import 'package:bcrypt/bcrypt.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) {
        log('Creating users table');
        return db.execute(
          'CREATE TABLE users(id INTEGER PRIMARY KEY, firstName TEXT, lastName TEXT, email TEXT, password TEXT)',
        );
      },
    );
  }

  Future<void> insertUser(
      String firstName, String lastName, String email, String password) async {
    final db = await database;
    // Hash the password
    String hashedPassword = hashPassword(password);
    log('Inserting user: $firstName $lastName $email');
    await db.insert(
      'users',
      {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': hashedPassword,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await database;
    log('Inside getUser func -> Entered Password: $password');
    List<Map<String, dynamic>> users = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (users.isNotEmpty) {
      log('Inside getUser func -> Stored Hashed Password: ${users[0]['password']}');
      bool passwordMatches = verifyPassword(password, users[0]['password']);
      log('Inside getUser func -> Password Verification Result: $passwordMatches');
      if (passwordMatches) {
        return users.first;
      }
    }
    return null;
  }

  String hashPassword(String password) {
    log('inside hashPassword fun, password: $password');
    final salt = BCrypt.gensalt();
    return BCrypt.hashpw(password, salt);
  }

  bool verifyPassword(String password, String hashedPassword) {
    log('Inside verifyPassword -> Input Password: $password');
    log('Inside verifyPassword -> Hashed Password from DB: $hashedPassword');
    return BCrypt.checkpw(password, hashedPassword);
  }

  Future<Map<String, dynamic>?> fetchUserFromDatabase(String email) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );

    if (maps.isNotEmpty) {
      return maps.first;
    } else {
      return null;
    }
  }
}
