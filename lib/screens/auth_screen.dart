import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
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
              const Card(
                margin: EdgeInsets.all(20),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(
                      16,
                    ),
                    child: Form(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              label: Text('email Address'),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                          ),
                          TextField(
                            decoration: InputDecoration(
                              label: Text('Password'),
                            ),
                            keyboardType: TextInputType.visiblePassword,
                            autocorrect: false,
                            textCapitalization: TextCapitalization.none,
                            obscureText: true,
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
