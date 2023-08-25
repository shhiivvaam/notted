import 'package:flutter/material.dart';
import 'package:mynotes/views/login_view.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'myNotes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginView(),
    ),
  );
}