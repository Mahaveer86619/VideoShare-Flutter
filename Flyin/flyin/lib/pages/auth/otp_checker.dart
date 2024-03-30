import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flyin/pages/auth/auth_gate.dart';
import 'package:flyin/pages/components/button.dart';
import 'package:flyin/pages/components/textfield.dart';

class OTPchecker extends StatefulWidget {
  final String verificationId;

  const OTPchecker({super.key, required this.verificationId});

  @override
  State<OTPchecker> createState() => _OTPcheckerState();
}

class _OTPcheckerState extends State<OTPchecker> {
  // phone textfield controller
  final otpController = TextEditingController();

  void onTap() {
    signInWithOtp(otpController.text.trim());
  }

  Future<void> signInWithOtp(String otp) async {
    final auth = FirebaseAuth.instance;
    final credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId, smsCode: otp);
    await auth.signInWithCredential(credential);
    // Handle successful sign-in logic
    Navigator.pushReplacement(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const AuthGate(),
      ),
    ); // Navigate back to main page
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

              //  phone number input
              const SizedBox(
                height: 50,
              ),

              const Text(
                "Enter your OTP number",
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(
                height: 10,
              ),

              MyTextField(
                hintText: "Enter OTP",
                controller: otpController,
                maxlength: 6,
              ),

              // submit button

              const SizedBox(
                height: 150,
              ),

              MyButton(
                text: "Get Started",
                onTap: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
