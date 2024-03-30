import 'package:flutter/material.dart';
import 'package:flyin/pages/add_video/add_videos.dart';
import 'package:flyin/pages/landing_page/home_page.dart';

// final selectedVideoProvider = StateProvider<Video?>((ref) => null);

class NavScreen extends StatefulWidget {
  const NavScreen({super.key});

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _selectedIndex = 0;

  void notificationTap() {}

  final _screens = [
    const HomePage(),
    const AddVideosPage(),
    const Scaffold(
      body: Center(
        child: Text("Library"),
      ),
    ),
    const Scaffold(
      body: Center(
        child: Text("Settings"),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Stack(
        // all screens will be rendered but only selected ones will be shown rest will be 'offstage'
        children: _screens
            .asMap()
            .map(
              (i, screen) => MapEntry(
                i,
                Offstage(
                  offstage: _selectedIndex != i,
                  child: screen,
                ),
              ),
            )
            .values
            .toList(),
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => {
          setState(() {
            _selectedIndex = i;
          })
        },
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.explore_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            selectedIcon: Icon(
              Icons.explore,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: "Explore",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.add_circle_outline,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            selectedIcon: Icon(
              Icons.add_circle,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: "Add videos",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.subscriptions_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            selectedIcon: Icon(
              Icons.subscriptions,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: "Library",
          ),
          NavigationDestination(
            icon: Icon(
              Icons.settings_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            selectedIcon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.primary,
            ),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
