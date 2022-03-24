import 'package:flutter/material.dart';
import 'package:notekeeper_app/components/note_tile.dart';

class NoteListingPage extends StatelessWidget {
  const NoteListingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 14),
        itemBuilder: (context, index) => NoteTile(),
        itemCount: 15,
      ),
    );
  }

  int sum(int a, int b){
    print(a+b);
    return a+b;
  }
}
