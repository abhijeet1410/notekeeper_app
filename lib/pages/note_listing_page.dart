import 'package:flutter/material.dart';
import 'package:notekeeper_app/components/note_tile.dart';
import 'package:sqflite/sqflite.dart';

import '../models/note.dart';
import '../utils/database_helper.dart';

class NoteListingPage extends StatefulWidget {
  const NoteListingPage({Key? key}) : super(key: key);

  @override
  State<NoteListingPage> createState() => _NoteListingPageState();
}

class _NoteListingPageState extends State<NoteListingPage> {

   DatabaseHelper databaseHelper = DatabaseHelper();
   List<Note>? noteList;
   int count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = <Note>[];
      updateListView();
    }
    return Scaffold(
      // backgroundColor: Colors.black12,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        centerTitle: true,
        title: const Text(
          "Note Keeper",
          style: TextStyle(color: Colors.white),
        ),
      ),
      // drawer: Drawer(
      // backgroundColor: Colors.black,
      // child: Icon(Icons.arrow_back_ios),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          int a = 10, b = 20;
          int result = sum(a, b);
          // Navigator.push(
          //     context, MaterialPageRoute(builder: (context) => AddNote()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.purple,
      ),
      body: count == 0 ? Center(child: Text("No notes to display")) : ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 14),
        itemBuilder: (context, index) => NoteTile(noteList![index]),
        itemCount: count,
      ),
    );
  }

  int sum(int a, int b){
    print(a+b);
    return a+b;
  }

  ListView getNoteListView() {

    TextStyle titleStyle = Theme.of(context).textTheme.headline5!;

    return ListView.builder(
      itemCount: count,
      itemBuilder: (BuildContext context, int position) {
        return Card(
          color: Colors.white,
          elevation: 2.0,
          child: ListTile(

            leading: CircleAvatar(
              backgroundColor: getPriorityColor(noteList![position].priority!),
              child: getPriorityIcon(noteList![position].priority!),
            ),

            title: Text(noteList![position].title!, style: titleStyle,),

            subtitle: Text(noteList![position].date!),

            trailing: GestureDetector(
              child: const Icon(Icons.delete, color: Colors.grey,),
              onTap: () {
                _delete(context, noteList![position]);
              },
            ),
            onTap: () {
              debugPrint("ListTile Tapped");
              navigateToDetail(noteList![position],'Edit Note');
            },
          ),
        );
      },
    );
  }

  // Returns the priority color
  Color getPriorityColor(int priority) {
    switch (priority) {
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;

      default:
        return Colors.yellow;
    }
  }

  // Returns the priority icon
  Icon getPriorityIcon(int priority) {
    switch (priority) {
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;

      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void navigateToDetail(Note note, String title) async {
    // bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return NoteDetail(note, title);
    // }));
    //
    // if (result == true) {
    //   updateListView();
    // }
  }

  void updateListView() {
    final Future<Database?> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          count = noteList.length;
        });
      });
    });
  }

  void updateListViewNew() async {
    final Database? db = await databaseHelper.initializeDatabase();
    List<Note> noteList = await databaseHelper.getNoteList();
    setState(() {
      this.noteList = noteList;
      count = noteList.length;
    });
  }
}
