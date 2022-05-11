import 'package:flutter/material.dart';
import 'package:notekeeper_app/models/note.dart';

class NoteTile extends StatelessWidget {
  final Note note;

  NoteTile(this.note);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // var route = MaterialPageRoute(
        //   builder: (context) => AddNote(change: true),
        // );
        // Navigator.push(context, route);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Text(
          note.title!,
          style: const TextStyle(color: Colors.black),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
