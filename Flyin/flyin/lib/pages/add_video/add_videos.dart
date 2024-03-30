// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flyin/pages/add_video/video_preview_page.dart';

enum RecordingStatus { started, stopped }

class AddVideosPage extends StatefulWidget {
  const AddVideosPage({super.key});

  @override
  State<AddVideosPage> createState() => _AddVideosPageState();
}

class _AddVideosPageState extends State<AddVideosPage> {
  bool _isLoading = true;
  late CameraController _cameraController;
  bool _isRecording = false;
  bool _isBackCamRecording = true;

  _recordVideo() async {
    if (_isRecording) {
      final file = await _cameraController.stopVideoRecording();
      setState(() => _isRecording = false);
      final route = MaterialPageRoute(
        fullscreenDialog: true,
        builder: (_) => VideoPreviewPage(filePath: file.path),
      );
      Navigator.push(context, route);
    } else {
      await _cameraController.prepareForVideoRecording();
      await _cameraController.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  _initCamera() async {
    final cameras = await availableCameras();
    final front = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    final back = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.back,
    );
    if (_isBackCamRecording) {
      _cameraController = CameraController(
        back,
        ResolutionPreset.max,
      );
    } else {
      _cameraController = CameraController(
        front,
        ResolutionPreset.max,
      );
    }
    await _cameraController.initialize();
    setState(() => _isLoading = false);
  }

  @override
  void initState() {
    super.initState();
    _initCamera();
  }

  @override
  void dispose() {
    _cameraController.dispose();
    super.dispose();
  }

  void _onFlipCameraButtonPressed() async {
    await _cameraController.dispose(); // Dispose existing controller

    setState(() {
      _isLoading = true;
      _isBackCamRecording = !_isBackCamRecording;
    });

    try {
      final cameras = await availableCameras();
      final selectedCamera = _isBackCamRecording
          ? cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.back)
          : cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front);

      _cameraController = CameraController(
        selectedCamera,
        ResolutionPreset.max,
      );
      await _cameraController.initialize();
    } catch (e) {
      // Handle camera init errors
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
      print(e);
      print(">>>>>>>>>>>>>>>>>>>>>>>>>>>>>><<<<<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
      _showCameraError();
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _showCameraError() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Error switching cameras')),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Flyin",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Icon(
                Icons.notifications,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
        body: Center(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CameraPreview(_cameraController),
              Padding(
                padding: const EdgeInsets.all(25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      backgroundColor: Colors.red,
                      child: Icon(_isRecording ? Icons.stop : Icons.circle),
                      onPressed: () => _recordVideo(),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    IconButton(
                      onPressed: _onFlipCameraButtonPressed,
                      icon: const Icon(
                        Icons.flip_camera_ios,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
