import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _fireabase = FirebaseAuth.instance;

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isLogin = true;
  var formKey = GlobalKey<FormState>();
  var emailText = '';
  var passwordText = '';
  @override
  Widget build(BuildContext context) {
    void onSubmit() async {
      final isValid = formKey.currentState!.validate();
      if (!isValid) {
        return;
      }

      if (isLogin) {
        // Login
        try {
          final userCredentials = await _fireabase.signInWithEmailAndPassword(
              email: emailText, password: passwordText);
        } on FirebaseAuthException catch (error) {
          if (error.code == 'user-not-found') {
            print('No user found for that email.');
          } else if (error.code == 'wrong-password') {
            print('Wrong password provided for that user.');
          }
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.code),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      } else {
        try {
          final userCredentials =
              await _fireabase.createUserWithEmailAndPassword(
                  email: emailText, password: passwordText);
        } on FirebaseAuthException catch (error) {
          if (error.code == 'firebase_auth/email-already-in-use') {
            print('The account already exists for that email.');
          }
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(error.code),
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(
                  bottom: 20,
                  top: 30,
                  left: 20,
                  right: 20,
                ),
                width: 200,
                child: Image.asset('assets/images/chat.png'),
              ),
              Card(
                margin: const EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(
                      16,
                    ),
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text('email Address'),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  !value.contains('@')) {
                                return 'Please enter a valid email address';
                              }
                              emailText = value.toString();
                              return null;
                            },
                            onSaved: (value) => emailText = value!,
                          ),
                          TextFormField(
                            decoration: const InputDecoration(
                              label: Text('Password'),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            obscureText: true,
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 7) {
                                return 'Password must be at least 7 characters long';
                              }
                              passwordText = value.toString();
                              return null;
                            },
                            onSaved: (value) => passwordText = value!,
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                            onPressed: onSubmit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context)
                                  .colorScheme
                                  .primaryContainer,
                            ),
                            child: Text(isLogin ? 'Login' : 'Sign Up'),
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                isLogin = !isLogin;
                              });
                            },
                            child: Text(isLogin
                                ? 'Create new account'
                                : 'I already have an account'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
