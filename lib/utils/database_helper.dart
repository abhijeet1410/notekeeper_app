import 'dart:io';
import 'package:notekeeper_app/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    if (_databaseHelper == null) {
      _databaseHelper = DatabaseHelper._createInstance();
    }
    return _databaseHelper!;
  }

  Future<Database?> get database async {
    if (_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';
  String colPriority = 'priority';

  initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String _path = directory.path + 'notes.db';

    // Open/Create the database at the given path
    var notesDb = await openDatabase(_path, version: 1, onCreate: _createDb);
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER,'
        ' $colDate TEXT)');
  }

  Future<int> insertNoteUsingRawQuery(Note note) async {
    Database? db = await database;
    var result = await db!.rawInsert(
        'INSERT INTO $noteTable ($colId, $colTitle, $colDescription, $colDate, $colPriority) VALUES (${note.id}, ${note.title}, ${note.description}, ${note.date}, ${note.priority})');
    return result;
  }

  Future<int> insertNote(Note note) async {
    Database? db = await database;
    var result = await db!.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updateNote(Note note) async {
    Database? db = await database;
    var result = await db!.update(noteTable, note.toMap(),
        where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> updateNoteUsingRawQuery(Note note) async {
    Database? db = await database;
    var result = await db!.rawUpdate(
        'UPDATE $noteTable SET $colTitle = ${note.title}, $colDescription = ${note.description} WHERE $colId = ${note.id}');
    return result;
  }

  Future<int> deleteNote(Note note) async {
    Database? db = await database;
    var result =
        await db!.delete(noteTable, where: '$colId = ?', whereArgs: [note.id]);
    return result;
  }

  Future<int> deleteNoteUsingRawQuery(Note note) async {
    Database? db = await database;
    var result =
        await db!.rawDelete('DELETE FROM $noteTable WHERE $colId = ${note.id}');
    return result;
  }
}
