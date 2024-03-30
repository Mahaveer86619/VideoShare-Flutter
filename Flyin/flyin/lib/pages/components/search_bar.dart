import 'package:flutter/material.dart';

class MySearchBar extends StatelessWidget {
  const MySearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        labelText: 'Search',
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.search),
        suffixIcon: Icon(Icons.filter_list),
      ),
    );
  }
}
