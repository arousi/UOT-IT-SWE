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
    String hashedPassword = hashPassword(password); // Hash password once
    log('Inserting user: $firstName $lastName $email');
    await db.insert(
      'users',
      {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': hashedPassword // Store only the hashed password
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    Map<String, dynamic>? user = await fetchUserFromDatabase(email);
    if (user != null) {
      String storedHashedPassword = user['password'];
      log("Inside getUser func -> Entered Password: $password");
      log("Inside getUser func -> Stored Hashed Password: $storedHashedPassword");

      bool isPasswordCorrect = verifyPassword(password, storedHashedPassword);
      log("Inside getUser func -> Password Verification Result: $isPasswordCorrect");

      if (isPasswordCorrect) {
        return user;
      } else {
        log("Password does not match");
        return null;
      }
    }
    return null;
  }

  String hashPassword(String password) {
    log("inside hashPassword fun, password: $password");
    return BCrypt.hashpw(password, BCrypt.gensalt());
  }

  bool verifyPassword(String password, String hashedPassword) {
    log("Inside verifyPassword -> Input Password: $password");
    log("Inside verifyPassword -> Hashed Password from DB: $hashedPassword");
    bool result = BCrypt.checkpw(password, hashedPassword);
    log("Inside verifyPassword -> Password Matches: $result");
    return result;
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
