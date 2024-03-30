import 'package:flutter/material.dart';
import 'package:flyin/pages/video_player/video_player.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flyin/data/data.dart';

class MyVideoCard extends StatelessWidget {
  final Video video;
  final void Function() profileTap;

  const MyVideoCard({super.key, required this.video, required this.profileTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerPage(video: video),
          ),
        )
      },
      child: Column(
        children: [
          // stack video thumbnail with timestamp
          Stack(
            children: [
              Image.network(
                video.thumbnailUrl,
                height: 220.0,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 14.0,
                right: 12.0,
                child: Container(
                  color: Colors.black,
                  child: Text(
                    video.duration,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall!
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
          // row of column title and details and options icon
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: profileTap,
                  child: CircleAvatar(
                    foregroundImage: NetworkImage(video.profileImageUrl),
                  ),
                ),
                const SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // title
                      Flexible(
                        child: Text(
                          video.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                      ),
                      // details
                      Flexible(
                        child: Text(
                          "${video.author} | ${video.views} | ${timeago.format(video.timeStamp)} | ${video.category}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
