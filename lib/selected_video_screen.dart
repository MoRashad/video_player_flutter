import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';

import 'package:video_player_app/models/video_model.dart';

class SelectedVideoScreen extends StatefulWidget {
  final int index;
  final Duration? startAt;
  const SelectedVideoScreen({
    Key? key,
    required this.index,
    this.startAt,
  }) : super(key: key);

  @override
  State<SelectedVideoScreen> createState() => _SelectedVideoScreenState();
}

class _SelectedVideoScreenState extends State<SelectedVideoScreen> {
  bool? isInitialized;
  BetterPlayerController? _betterPlayerController;

  @override
  void initState() {
    super.initState();
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network, videos[widget.index].videoUrl);
    _betterPlayerController = BetterPlayerController(
      const BetterPlayerConfiguration(),
      betterPlayerDataSource: betterPlayerDataSource,
    );

    _betterPlayerController!.addEventsListener(onPlayerEvent);
  }

  void onPlayerEvent(BetterPlayerEvent event) {
    if (event.betterPlayerEventType == BetterPlayerEventType.initialized) {
      if (widget.startAt != null) {
        _betterPlayerController!.seekTo(widget.startAt!);
        _betterPlayerController!.play();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(videos[widget.index].title),
        centerTitle: true,
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: 16 / 9,
          child: BetterPlayer(
            controller: _betterPlayerController!,
          ),
        ),
      ),
    );
  }
}
