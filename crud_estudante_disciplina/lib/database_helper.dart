import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _instance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'cadastro_academico.db'),
      version: 1,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE estudantes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        matricula TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE disciplinas (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        professor TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE cursando (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        estudante_id INTEGER NOT NULL,
        disciplina_id INTEGER NOT NULL,
        UNIQUE(estudante_id, disciplina_id),
        FOREIGN KEY(estudante_id) REFERENCES estudantes(id) ON DELETE CASCADE,
        FOREIGN KEY(disciplina_id) REFERENCES disciplinas(id) ON DELETE CASCADE
      )
    ''');
  }
}
