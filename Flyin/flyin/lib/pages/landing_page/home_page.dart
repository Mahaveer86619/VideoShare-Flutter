// ignore_for_file: avoid_print, use_build_context_synchronously
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flyin/data/data.dart';
import 'package:flyin/pages/components/search_bar.dart';
import 'package:flyin/pages/components/video_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Video> _videos = [];

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchVideos();
  }

  void profileTap() {
    print("Profile Tapped");
  }

  void notificationTap() {
    print("Notification Tapped");
  }

  Future<void> _fetchVideos() async {
    setState(() => _isLoading = true);

    try {
      final videosRef = FirebaseFirestore.instance.collection('videos');
      final querySnapshot = await videosRef.get();
      _videos = querySnapshot.docs.map((doc) {
        final data = doc.data();
        return Video(
          author: data['author'] as String,
          title: data['title'] as String,
          description: data['description'] as String,
          category: data['category'] as String,
          url: data['url'] as String,
          location: data['location'] as String,
          timeStamp: (data['timestamp'] as Timestamp).toDate(),
          duration: '10.52',
          thumbnailUrl:
              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQtn9QG0kjjNUjoGkFZWBtMC5p_pufkcfBrw&s',
          views: '100k',
        );
      }).toList();
    } catch (error) {
      print("Error fetching videos: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Error fetching videos"),
          backgroundColor: Theme.of(context).colorScheme.error,
        ),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: Text(
          'Flyin',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onBackground,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => notificationTap,
            child: Icon(
              Icons.notifications,
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: MySearchBar(),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: ListView(
                children: _videos
                    .map(
                      (video) => MyVideoCard(
                        video: video,
                        profileTap: () {
                          profileTap();
                        },
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
