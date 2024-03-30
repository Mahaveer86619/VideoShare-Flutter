import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flyin/firebase_options.dart';
import 'package:flyin/pages/auth/auth_gate.dart';
import 'package:flyin/theme/dark_theme.dart';
import 'package:flyin/theme/light_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp()); // access provider anywhere in the app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Orientating portrait up
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flyin',
      theme: lightMode,
      darkTheme: darkMode,
      home: const SafeArea(
        child: AuthGate(),
      ),
    );
  }
}
