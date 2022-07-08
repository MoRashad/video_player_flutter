import 'package:flutter/material.dart';

import 'package:inview_notifier_list/inview_notifier_list.dart';

import 'package:video_player_app/models/video_model.dart';
import 'package:video_player_app/videos_list.dart';

class VideoplayerList extends StatefulWidget {
  const VideoplayerList({Key? key}) : super(key: key);

  @override
  State<VideoplayerList> createState() => _VideoplayerListState();
}

class _VideoplayerListState extends State<VideoplayerList> {
  bool isPlaying = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Video player list',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: InViewNotifierList(
          isInViewPortCondition:
              (double deltaTop, double deltaBottom, double vpHeight) {
            return deltaTop < (0.5 * vpHeight) &&
                deltaBottom > (0.5 * vpHeight);
          },
          itemCount: videos.length,
          builder: (BuildContext context, int index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  videos[index].title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                InViewNotifierWidget(
                  id: '$index',
                  builder:
                      (BuildContext context, bool isInView, Widget? child) {
                    return VideosList(
                      index: index,
                      isInView: isInView,
                    );
                  },
                ),
                const SizedBox(height: 15),
              ],
            );
          },
        ),
      ),
    );
  }
}
