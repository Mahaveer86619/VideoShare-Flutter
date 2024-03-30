import 'package:flutter/material.dart';

class VideoDetailsDialog extends StatelessWidget {
  final String filePath;

  const VideoDetailsDialog({
    super.key,
    required this.filePath,
    required this.titleEditingController,
    required this.descriptionController,
    required this.onVideoSave,
    required this.categoryController,
  });

  final void Function()? onVideoSave;

  final TextEditingController titleEditingController;
  final TextEditingController descriptionController;
  final TextEditingController categoryController;


  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Video Details'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            TextField(
              controller: titleEditingController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              maxLines: null, // Expand to accommodate multiple lines
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: categoryController,
              decoration: const InputDecoration(labelText: 'Category'),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => {Navigator.pop(context)},
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Handle video saving with details
            Navigator.pop(context);
            onVideoSave!();
          },
          child: const Text('Post'),
        ),
      ],
    );
  }
}
