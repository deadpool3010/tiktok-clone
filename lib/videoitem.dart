// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:tiktok/add.dart';

import 'package:video_player/video_player.dart';

class videoitem extends StatefulWidget {
  final String videourl;
  const videoitem({
    Key? key,
    required this.videourl,
  }) : super(key: key);

  @override
  State<videoitem> createState() => _videoitemState();
}

class _videoitemState extends State<videoitem> {
  VideoPlayerController? videocontroller;

  @override
  void initState() {
    super.initState();

    VideoPlayerController controller =
        VideoPlayerController.network(widget.videourl)
          ..initialize().then((value) {
            videocontroller!.play();
            videocontroller!.setVolume(1);
          });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(color: Colors.black),
      child: VideoPlayer(videocontroller!),
    );
  }
}
