import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/main.dart';

class NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              // print(value);

              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);

                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login/', (_) => false);
                  }
                // devtools.log(shouldLogout.toString());
                // break;
              }

              //? use from import 'dart:developers' tools
              // devtools.log(value
              //     .toString()); //? this is nothing to do with the functionality, but it is just a dart function that we have imported above with the alias name devtools, this is done to make a difference in the console, every time when we prints the Onselected - Value
              //* toString() -> is very needded here to conver the value to an dart understandable format
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                    value: MenuAction.logout, child: Text('Sign out')),
              ];
            },
          )
        ],
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          /// if we make this { Alertdialog } -> const  } then the TextButton in it will arise error that, Invalid Constant Value
          title: const Text('Sign Out'),
          content: const Text('Are you sure you want to Sign Out?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Log Out')),
          ],
        );
      }).then((value) => value ?? false);
}
