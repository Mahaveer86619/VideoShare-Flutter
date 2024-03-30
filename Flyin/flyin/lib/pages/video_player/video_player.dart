import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flyin/data/data.dart';
import 'package:flyin/pages/components/comment_card.dart';
import 'package:timeago/timeago.dart' as timeago;

class VideoPlayerPage extends StatefulWidget {
  final Video video;
  const VideoPlayerPage({
    super.key,
    required this.video,
  });

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late CachedVideoPlayerController videoPlayerController;
  late CustomVideoPlayerController _customVideoPlayerController;

  List<Comments> comments = [];

  @override
  void initState() {
    super.initState();
    videoPlayerController =
        CachedVideoPlayerController.network(widget.video.url)
          ..initialize().then((value) => setState(() {}));
    _customVideoPlayerController = CustomVideoPlayerController(
      context: context,
      videoPlayerController: videoPlayerController,
    );
  }

  @override
  void dispose() {
    _customVideoPlayerController.dispose();
    super.dispose();
  }

  void onPressedLike() {}
  void onPressedDislike() {}
  void onPressedShare() {}
  void onPressedViewAllVideos() {}
  void notificationTap() {
    debugPrint("Notification Tapped");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text(
          'Flyin',
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: CustomVideoPlayer(
                customVideoPlayerController: _customVideoPlayerController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.video.title,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    widget.video.description,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: onPressedLike,
                        icon: Icon(
                          Icons.thumb_up,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      IconButton(
                        onPressed: onPressedDislike,
                        icon: Icon(
                          Icons.thumb_down,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      IconButton(
                        onPressed: onPressedShare,
                        icon: Icon(
                          Icons.share,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24.0),
                  Column(
                    children: [
                      Text(
                        "${widget.video.views} | ${timeago.format(widget.video.timeStamp)} | ${widget.video.category}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 32.0),
                      Container(
                        color: Theme.of(context).colorScheme.surface,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 20,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                widget.video.views,
                                style: TextStyle(
                                  fontSize: 18,
                                  color:
                                      Theme.of(context).colorScheme.onBackground,
                                ),
                              ),
                              TextButton(
                                onPressed: onPressedViewAllVideos,
                                child: const Text('View All'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 48.0),
                      Text(
                        'Comments',
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ListView.builder(
                        itemCount: comments.length,
                        itemBuilder: (context, index) {
                          return CommentCard(comment: comments[index]);
                        },
                      ),
                    ],
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
