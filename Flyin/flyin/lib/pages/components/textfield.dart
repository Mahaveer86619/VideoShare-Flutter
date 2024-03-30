import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final int maxlength;

  const MyTextField({
    super.key,
    required this.hintText,
    required this.controller,
    required this.maxlength,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:
          TextInputType.phone,
      maxLines: 1,
      maxLength: maxlength,
      autocorrect: false,
      onChanged: (value) {
        controller.text = value; // Update controller text
      },
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary),
        ),
        fillColor: Theme.of(context).colorScheme.surface,
        filled: true,
        hintText: hintText,
        hintStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
