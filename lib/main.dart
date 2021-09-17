import 'package:filter_app/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'ToDoшка',
            style: GoogleFonts.lobster(color: Colors.white, fontSize: 40),
          ),
          backgroundColor: Colors.deepOrange,
        ),

        body: Home(),
      ),
    );
  }
}
