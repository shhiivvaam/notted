import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'dart:developer' as devtools show log;
import '../firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration:
                const InputDecoration(hintText: 'Enter your Email here'),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                const InputDecoration(hintText: 'Enter your Password here'),
          ),
          TextButton(
              onPressed: () async {
                await Firebase.initializeApp(
                  options: DefaultFirebaseOptions.currentPlatform(),
                );
                final email = _email.text;
                final password = _password.text;

                try {
                  final userCredential =
                      await FirebaseAuth.instance.signInWithEmailAndPassword(
                          // here we are not creating user Email and Password like the Register View Screen
                          email: email,
                          password: password);
                  devtools.log(userCredential.toString());
                } on FirebaseAuthException catch (e) {
                  // print('Something wrong with Registeration');
                  // print(e.code);
                  if (e.code == 'weak-password') {
                    devtools.log('Weak Password');
                  } else if (e.code == 'email-already-in-use') {
                    devtools.log('Email is Already In Use');
                  } else if (e.code == 'invalid-email') {
                    devtools.log('Invalid Email');
                  }
                }
              },
              child: const Text('Register')),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(loginRoute, (route) => false);
              },
              child: const Text('Already Registered? Login here!'))
        ],
      ),
    );
  }
}




// return Column(
//    children: [
//      TextField(
//        controller: _email,
//        enableSuggestions: false,
//        autocorrect: false,
//        keyboardType: TextInputType.emailAddress,
//        decoration: const InputDecoration(
//            hintText: 'Enter your Email here'),
//      ),
//      TextField(
//        controller: _password,
//        obscureText: true,
//        enableSuggestions: false,
//        autocorrect: false,
//        decoration: const InputDecoration(
//            hintText: 'Enter your Password here'),
//      ),
//      TextButton(
//          onPressed: () async {
//            await Firebase.initializeApp(
//              options: DefaultFirebaseOptions.currentPlatform(),
//            );
//            final email = _email.text;
//            final password = _password.text;

//            try {
//              final userCredential = await FirebaseAuth.instance
//                  .signInWithEmailAndPassword(
//                      // here we are not creating user Email and Password like the Register View Screen
//                      email: email,
//                      password: password);
//              print(userCredential);
//            } on FirebaseAuthException catch (e) {
//              // print('Something wrong with Registeration');
//              // print(e.code);
//              if (e.code == 'weak-password') {
//                print('Weak Password');
//              } else if (e.code == 'email-already-in-use') {
//                print('Email is Already In Use');
//              } else if (e.code == 'invalid-email') {
//                print('Invalid Email');
//              }
//            }
//          },
//          child: const Text('Register')),
//    ],
//  );











    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('Register'),
    //       backgroundColor: Colors.deepPurpleAccent,
    //     ),
    //     body: FutureBuilder(
    //       future: Firebase.initializeApp(
    //         options: DefaultFirebaseOptions.currentPlatform(),
    //       ),
    //       builder: (context, snapshot) {
    //         switch (snapshot.connectionState) {
    //           case ConnectionState.done:
    //             return const LoginView();
    //           default:
    //             return const Text('Loading...');
    //         }
    //       },
    //     ));