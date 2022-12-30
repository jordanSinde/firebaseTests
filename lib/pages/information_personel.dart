import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class InforamtionPersonnel extends StatelessWidget {
  InforamtionPersonnel({super.key});
//un utilisateur
  final user = FirebaseAuth.instance.currentUser!;
//fonction de deconnexion
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: signUserOut,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            "LOGGED IN AS : ${user.email}",
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
