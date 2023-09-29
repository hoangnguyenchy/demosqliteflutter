import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database? _database;

  DatabaseHelper._privateConstructor();

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'my_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE accounts(id INTEGER PRIMARY KEY AUTOINCREMENT, username TEXT, password TEXT, age INTEGER, imageUrl TEXT)',

        );
      },
    );

  }

  Future<int> insertAccount(Map<String, dynamic> account) async {
    final db = await database;
    return await db!.insert('accounts', account);
  }

  Future<List<Map<String, dynamic>>> getAccounts() async {
    final db = await database;
    return await db!.query('accounts');
  }
  Future<List<Map<String, dynamic>>> queryAccount(String username,password) async {
    final db = await database;
    return await db!.query('accounts', where: 'username = ? AND password = ?', whereArgs: [username,password]);
  }
  Future<List<Map<String, dynamic>>> queryAccountByUsername(String username) async {
    final db = await database;
    return await db!.query('accounts', where: 'username = ?', whereArgs: [username]);
  }

  Future<int> updateAccount(Map<String, dynamic> updatedAccount) async {
    final db = await database;
    return await db!.update(
      'accounts',
      updatedAccount,
      where: 'id = ?',
      whereArgs: [updatedAccount['id']],
    );
  }
  Future<int> deleteAccount(int accountId) async {
    final db = await database;
    return await db!.delete(
      'accounts',
      where: 'id = ?',
      whereArgs: [accountId],
    );
  }

}

