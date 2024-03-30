import 'package:flutter/material.dart';

class MySliverAppBar extends StatelessWidget {
  const MySliverAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      leading: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, left: 8),
        child: Text(
          "Flyin",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
          child: Icon(
            Icons.notifications,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
      ],
    );
  }
}
