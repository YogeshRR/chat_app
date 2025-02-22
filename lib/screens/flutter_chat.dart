import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FlutterChat extends StatelessWidget {
  const FlutterChat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Chat'),
      ),
    );
  }
}
