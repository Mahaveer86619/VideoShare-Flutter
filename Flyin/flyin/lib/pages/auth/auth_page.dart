// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flyin/pages/auth/otp_checker.dart';
import 'package:flyin/pages/components/button.dart';
import 'package:flyin/pages/components/textfield.dart';
import 'package:permission_handler/permission_handler.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // phone textfield controller
  final phoneController = TextEditingController();

  void onTap() {
    verifyPhoneNumber(phoneController.text.trim());
  }

  Future<void> checkPermissions() async {
    Map<Permission, PermissionStatus> status = await [
      Permission.camera,
      Permission.microphone,
      Permission.locationWhenInUse,
      Permission.location,
    ].request();

    if (status[Permission.camera] == PermissionStatus.granted &&
        status[Permission.microphone] == PermissionStatus.granted &&
        status[Permission.locationWhenInUse] == PermissionStatus.granted &&
        status[Permission.location] == PermissionStatus.granted) {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
      print("Permission Granted");
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
    } else {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
      print("Permission Denied");
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
    }
  }

    @override
  void initState() {
    super.initState();
    checkPermissions();
  }

  Future<void> verifyPhoneNumber(String phoneNumber) async {
    final auth = FirebaseAuth.instance;
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
        print(e.message);
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
      },
      codeSent: (String verificationId, int? resendToken) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => OTPchecker(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text("Auto-retrieval timed out"),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
        print("Auto-retrieval timed out: $verificationId");
        print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              // Logo
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/images/app_logo.png'),
                ],
              ),

              // phone number input
              const SizedBox(
                height: 50,
              ),

              const Text(
                "Enter your phone number",
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(
                height: 10,
              ),

              MyTextField(
                hintText: "Enter phone number",
                controller: phoneController,
                maxlength: 13,
              ),

              // submit button

              const SizedBox(
                height: 150,
              ),

              MyButton(
                text: "Submit",
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
