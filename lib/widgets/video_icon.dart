import 'package:flutter/material.dart';

class VideoIcon extends StatelessWidget {
  final String? mediaType;
  final double? iconSize;
  const VideoIcon({super.key, required this.mediaType, this.iconSize});

  @override
  Widget build(BuildContext context) {
    if (mediaType != 'video') {
      return Container();
    } else {
      return Align(
        child: Icon(Icons.play_circle_fill_outlined,
            color: Colors.white, size: iconSize),
      );
    }
  }
}
