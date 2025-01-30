import 'package:github_stars_app/model/respositoryModel.dart';
import 'package:github_stars_app/model/tickermodel.dart';
import 'package:github_stars_app/model/transactinModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() {
    return _instance;
  }

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = join(await getDatabasesPath(), 'app_database.db');

    // Uncomment the following line to delete the database for testing purposes
    // await deleteDatabase(path);

    return await openDatabase(
      path,
      version: 2, // Increment the version number
      onCreate: (db, version) async {
        print("📌 Creating database tables...");

        await db.execute('''
        CREATE TABLE repositories (
          id INTEGER PRIMARY KEY,
          name TEXT,
          description TEXT,
          stars INTEGER,
          owner TEXT,
          avatarUrl TEXT
        )
      ''');

        await db.execute('''
        CREATE TABLE tickets (
          id TEXT PRIMARY KEY,
          title TEXT,
          description TEXT,
          location TEXT,
          date TEXT,
          attachment TEXT
        )
      ''');

        await db.execute('''
       CREATE TABLE transactions (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          description TEXT NOT NULL,
          status TEXT NOT NULL,
          dateTime INTEGER
        )
      ''');

        print("✅ Database tables created successfully.");
      },
    );
  }

  Future<void> insertRepositories(List<RepositoryModel> repos) async {
    final db = await database;
    await db.delete('repositories');
    for (var repo in repos) {
      await db.insert('repositories', repo.toMap());
    }
  }

  Future<List<RepositoryModel>> getRepositories() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('repositories');
    return maps.map((map) => RepositoryModel.fromMap(map)).toList();
  }

  Future<void> insertTicket(TicketModel ticket) async {
    final db = await database;
    await db.insert(
      'tickets',
      ticket.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TicketModel>> getTickets() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('tickets');
    return List.generate(maps.length, (i) {
      return TicketModel.fromMap(maps[i]);
    });
  }

  Future<void> insertTransaction(TransactionModel trans) async {
    final db = await database;
    await db.insert(
      'transactions',
      trans.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TransactionModel>> getErrorTransactions() async {
    final db = await database;
    final result = await db.query(
      'transactions',
      where: 'status = ?',
      whereArgs: ['Error'],
    );
    return result.map((json) => TransactionModel.fromMap(json)).toList();
  }
}
