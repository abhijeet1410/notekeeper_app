import 'dart:io';
import 'package:notekeeper_app/models/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper; // Singleton DatabaseHelper
  static Database? _database; // Singleton Database

  DatabaseHelper._createInstance(); // Named constructor to create instance of DatabaseHelper

  factory DatabaseHelper() {
    _databaseHelper ??= DatabaseHelper._createInstance();
    return _databaseHelper!;
  }

  Future<Database?> get database async {
    _database ??= await initializeDatabase();
    return _database;
  }

  String noteTable = 'note_table';
  String colId = 'id';
  String colTitle = 'title';
  String colDescription = 'description';
  String colDate = 'date';
  String colPriority = 'priority';

  Future<Database?> initializeDatabase() async {
    // Get the directory path for both Android and iOS to store database.
    Directory directory = await getApplicationDocumentsDirectory();
    String _path = directory.path + 'notes.db';

    // Open/Create the database at the given path
    var notesDb = await openDatabase(_path, version: 1, onCreate: _createDb);
    return notesDb;
  }

  Future<void> _createDb(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT,'
        ' $colTitle TEXT, $colDescription TEXT, $colPriority INTEGER,'
        ' $colDate TEXT)');
  }

  // Fetch Operation: Get all note objects from database
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database? db = await database;

//		var result = await db.rawQuery('SELECT * FROM $noteTable order by $colPriority ASC');
    var result = await db!.query(noteTable, orderBy: '$colPriority ASC');
    return result;
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

  // Get number of Note objects in database
  Future<int?> getCount() async {
    Database? db = await database;
    List<Map<String, dynamic>> notes = await db!.rawQuery('SELECT COUNT (*) from $noteTable');
    int? result = Sqflite.firstIntValue(notes);
    return result;
  }

  // Get the 'Map List' [ List<Map> ] and convert it to 'Note List' [ List<Note> ]
  Future<List<Note>> getNoteList() async {

    List<Map<String, dynamic>> noteMapList = await getNoteMapList(); // Get 'Map List' from database
    int count = noteMapList.length;         // Count the number of map entries in db table

    List<Note> noteList = <Note>[];
    // For loop to create a 'Note List' from a 'Map List'
    for (int i = 0; i < count; i++) {
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }

    return noteList;
  }
}
