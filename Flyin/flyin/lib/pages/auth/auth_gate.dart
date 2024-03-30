import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flyin/pages/auth/auth_page.dart';
import 'package:flyin/pages/navigation/nav_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const NavScreen(); // user is logged in
          } else {
            return const AuthPage(); // user is not logged in
          }
        },
      ),
    );
  }
}
