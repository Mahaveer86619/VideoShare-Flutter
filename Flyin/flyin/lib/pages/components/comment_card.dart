import 'package:flutter/material.dart';
import 'package:flyin/data/data.dart';

class CommentCard extends StatelessWidget {
  final Comments comment;
  const CommentCard({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Profile Icon
        CircleAvatar(
          foregroundImage: NetworkImage(comment.profileImageUrl),
        ),

        // Column of author and comment
        Column(
          children: [
            // Author
            Text(
              comment.author,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(
              height: 24,
            ),
            Text(
              comment.comment,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            // Comment
          ],
        ),
      ],
    );
  }
}
