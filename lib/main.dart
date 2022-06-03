import 'package:flutter/material.dart';
import 'package:notekeeper_app/pages/currency_page.dart';

import 'pages/note_listing_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'NoteKeeper',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CurrencyPage(),
    );
  }
}
