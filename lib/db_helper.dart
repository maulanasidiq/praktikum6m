import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'todo.dart';

class DBHelper {
  static Database? _db;

  static Future<Database> get db async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  static Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'todo.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE todos(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT,
            description TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  static Future<int> insert(Todo todo) async {
    final dbClient = await db;
    return await dbClient.insert('todos', todo.toMap());
  }

  static Future<List<Todo>> getTodos() async {
    final dbClient = await db;
    final List<Map<String, dynamic>> maps = await dbClient.query('todos');
    return List.generate(maps.length, (i) => Todo.fromMap(maps[i]));
  }

  static Future<int> update(Todo todo) async {
    final dbClient = await db;
    return await dbClient
        .update('todos', todo.toMap(), where: 'id = ?', whereArgs: [todo.id]);
  }

  static Future<int> delete(int id) async {
    final dbClient = await db;
    return await dbClient.delete('todos', where: 'id = ?', whereArgs: [id]);
  }
}
