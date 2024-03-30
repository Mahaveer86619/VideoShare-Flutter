// ignore_for_file: avoid_print, unnecessary_null_comparison

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flyin/pages/components/video_details_dialog.dart';
import 'package:flyin/pages/navigation/nav_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:video_player/video_player.dart';

class VideoPreviewPage extends StatefulWidget {
  final String filePath;

  const VideoPreviewPage({
    super.key,
    required this.filePath,
  });

  @override
  State<VideoPreviewPage> createState() => VideoStatePreviewPage();
}

class VideoStatePreviewPage extends State<VideoPreviewPage> {
  late VideoPlayerController _videoPlayerController;

  final _titleEditingController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();

  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _user = FirebaseAuth.instance;

  bool _isUploading = false;

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  Future _initVideoPlayer() async {
    _videoPlayerController = VideoPlayerController.file(
      File(widget.filePath),
    );
    await _videoPlayerController.initialize();
    await _videoPlayerController.setLooping(false);
    await _videoPlayerController.play();
  }

  Future<Position> _getCurrentPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check for permissions
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are disabled.
      // Request user to enable them.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    try {
      return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
    } catch (e) {
      return Future.error('Error fetching location: $e');
    }
  }

  Future onVideoSave() async {
    // ... code to save details to file storage ...
    print("\n\n\n\nFile uploading Now\n\n\n\n");

    // Fetch course location
    Position position = await _getCurrentPosition();
    String courseLocation = position != null
        ? "${position.latitude}, ${position.longitude}"
        : "Unknown Location";

    setState(() {
      _isUploading = true;
    });

    final file = File(widget.filePath);
    final ref = _storage.ref().child('videos/${DateTime.now()}.mp4');
    final uploadTask = ref.putFile(file);

    final snapshot = await uploadTask.whenComplete(() => null);
    final url = await snapshot.ref.getDownloadURL();

    saveVideoDetails(_titleEditingController.text, _descriptionController.text,
        _categoryController.text, url, courseLocation);

    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
    print(
        "Video Saved: \n> Title: ${_titleEditingController.text}, \n> Description: ${_descriptionController.text}, \n> Category: ${_categoryController.text}, \n> File path: ${widget.filePath}, \n> Location: $courseLocation,  \n> Download URL: $url");
    print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
  }

  void saveVideoDetails(
    String title,
    String description,
    String category,
    String url,
    String location,
  ) async {
    // ... code to save details to Firestore ...
    final userId = _user.currentUser?.phoneNumber;

    final databaseRef = _db.collection('videos');

    // Add other fields like duration, thumbnailUrl, views (if available)
    final videoData = <String, dynamic>{
      'title': title,
      'author': userId,
      'description': description,
      'category': category,
      'url': url,
      'location': location,
      "timestamp": FieldValue.serverTimestamp(),
    };

    databaseRef.doc().set(videoData).onError((e, _) {
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
      print('Error uploading video: $e');
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Error uploading video'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
    });

    setState(() {
      _isUploading = false;
    });

    videoUploadSuccess();
  }

  void videoUploadSuccess() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const NavScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isUploading) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Uploading...',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Preview',
            style: TextStyle(color: Theme.of(context).colorScheme.onBackground),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.surface,
          actions: [
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: () async {
                await showDialog(
                  context: context,
                  builder: (context) => VideoDetailsDialog(
                    filePath: widget.filePath,
                    titleEditingController: _titleEditingController,
                    descriptionController: _descriptionController,
                    categoryController: _categoryController,
                    onVideoSave: onVideoSave,
                  ),
                );
              },
            )
          ],
        ),
        extendBodyBehindAppBar: true,
        body: FutureBuilder(
          future: _initVideoPlayer(),
          builder: (context, state) {
            if (state.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return VideoPlayer(_videoPlayerController);
            }
          },
        ),
      );
    }
  }
}
