// ignore_for_file: must_be_immutable

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

import 'package:video_player_app/models/video_model.dart';
import 'package:video_player_app/selected_video_screen.dart';

class VideosList extends StatefulWidget {
  int index;
  bool isInView;

  VideosList({
    Key? key,
    required this.index,
    required this.isInView,
  }) : super(key: key);

  @override
  State<VideosList> createState() => _VideosListState();
}

class _VideosListState extends State<VideosList> {
  late BetterPlayerController betterPlayerController;
  bool isMute = true;
  bool isPlaying = true;
  Duration? lastPosition;
  @override
  void initState() {
    super.initState();

    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, videos[widget.index].videoUrl,
        cacheConfiguration:
            const BetterPlayerCacheConfiguration(useCache: true));

    betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(
        //autoPlay: widget.isInView ? true : false,
        looping: true,
        controlsConfiguration: BetterPlayerControlsConfiguration(
          showControls: false,
        ),
      ),
      betterPlayerDataSource: betterPlayerDataSource,
    );
    betterPlayerController.setVolume(0);
    betterPlayerController.addEventsListener(onPlayerEvent);
  }

  void onPlayerEvent(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.progress) {
      videos[widget.index].lastPosition =
          event.parameters!["progress"] as Duration?;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isInView && isPlaying == true) {
      betterPlayerController.play();
    } else {
      betterPlayerController.pause();
    }
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectedVideoScreen(
                  index: widget.index,
                  startAt: videos[widget.index].lastPosition,
                ),
              ),
            );
            betterPlayerController.pause();
          },
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: BetterPlayer(
              controller: betterPlayerController,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: IconButton(
            onPressed: () {
              setState(() {
                if (isPlaying == true) {
                  isPlaying = false;
                  betterPlayerController.pause();
                } else {
                  isPlaying = true;
                  betterPlayerController.play();
                }
              });
            },
            icon: Icon(
              betterPlayerController.isPlaying()!
                  ? Icons.pause
                  : Icons.play_arrow,
              color: Colors.white,
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: IconButton(
            onPressed: () {
              setState(() {
                if (isMute == true) {
                  isMute = false;
                  betterPlayerController.setVolume(1);
                } else {
                  isMute = true;
                  betterPlayerController.setVolume(0);
                }
              });
            },
            icon: Icon(
              isMute ? Icons.volume_mute : Icons.volume_up,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
