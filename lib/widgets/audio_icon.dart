import 'package:flutter/material.dart';

class AudioIcon extends StatelessWidget {
  final String? url;
  final double? iconSize;
  final height;
  const AudioIcon({Key? key, required this.url, this.iconSize, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url == '') {
      return Container();
    } else {
      return Align(
        alignment: Alignment.center,
        child: Container(
          height: height,
          child: Icon(Icons.play_circle_fill_outlined,
              color: Colors.white, size: iconSize),
        ),
      );
    }
  }
}
