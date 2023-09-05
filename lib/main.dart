import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/views/login_view.dart';
import 'package:mynotes/views/notes_view.dart';
import 'package:mynotes/views/register_view.dart';
import 'package:mynotes/views/verify_email_view.dart';
// import 'dart:developer' as devtools show log;

import 'firebase_options.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'myNotes',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),    
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
        '/notes/': (context) => const NotesView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform(),
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              if (user.emailVerified) {
                // print("Email is Verified");
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          // return const NotesView();
          // // final emailVerified = user?.emailVerified ?? false;

          // if (user?.emailVerified ?? false) {
          //   // print('You are a verified user');
          // } else {
          //   //! here we are just showing the content of the VerifyEmailView Page, we are just putting the content fof VerifyEmailView PAges Content over out main Screen
          //   return const VerifyEmailView();

          //   //! here we were returning a whole new screen, i.e, re-routing the screen to a new screen window
          //   // Navigator.of(context).push(
          //   //   MaterialPageRoute(
          //   //       builder: (context) => const VerifyEmailView()),
          //   // );
          //   // print('You need to verify you Email Address')
          // }
          // return const LoginView();
          // return const Text('Done');
          default:
            // return const Text('Loading...');
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => NotesViewState();
}
