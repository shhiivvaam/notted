import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
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
        title: const Text('Login'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            enableSuggestions: false,
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(hintText: 'Enter your Email here'),
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
                  final userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: email, password: password);
                  print(userCredential);
                  // print("Hello Shivam");
                } on FirebaseAuthException catch (e) {
                  print(e.code);
                  if (e.code == 'user-not-found') {
                    print('User Not Found');
                  } else if (e.code == 'wrong-password') {
                    print('Wrong Password');
                  }
                }
                // catch (e) {
                //   print('Something bad happened');
                //   print(e.runtimeType);
                //   print(e);
                // }
              },
              child: const Text('Login')),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/register/', (route) => false);
              },
              child: const Text('Not Registered yet? Register here!'))
        ],
      ),
    );
  }
}






// return Scaffold(
// appBar: AppBar(
//   title: const Text('Login'),
//   backgroundColor: Colors.deepPurpleAccent,
// ),
// body: FutureBuilder(
//   future: Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform(),
//   ),
//   builder: (context, snapshot) {
//     switch (snapshot.connectionState) {
//       case ConnectionState.done:
        
//       default:
//         return const Text('Loading...');
//     }
//   },
// ));