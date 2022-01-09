import 'package:flick_video_player/flick_video_player.dart';

import 'package:flutter/material.dart';
import 'package:video_player_assignment/componets/portrait_controls.dart';
import 'package:video_player_assignment/pages/models/video_list_model.dart';
import 'package:video_player_assignment/utils/utils.dart';
import 'package:video_player_assignment/video_managers/video_manager.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:video_player/video_player.dart';

class PlayerView extends StatefulWidget {
  const PlayerView({Key? key, this.videoData, required this.flickMultiManager})
      : super(key: key);

  final Data? videoData;
  final VideoManager flickMultiManager;

  @override
  _PlayerViewState createState() => _PlayerViewState();
}

class _PlayerViewState extends State<PlayerView> {
  late FlickManager flickManager;

  @override
  void initState() {
    flickManager = FlickManager(
      videoPlayerController:
          VideoPlayerController.network(widget.videoData!.videoUrl)
            ..setLooping(true),
      autoPlay: false,
    );
    widget.flickMultiManager.init(flickManager);

    super.initState();
  }

  @override
  void dispose() {
    widget.flickMultiManager.remove(flickManager);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: ObjectKey(flickManager),
      onVisibilityChanged: (visiblityInfo) {
        print('visiblityInfo ${visiblityInfo.visibleFraction}');
        if (visiblityInfo.visibleFraction > 0.9) {
          widget.flickMultiManager.play(flickManager);
        }
      },
      child: Container(
          child: Column(
        children: [
          Stack(
            children: [
              FlickVideoPlayer(
                flickManager: flickManager,
                flickVideoWithControls: FlickVideoWithControls(
                  // closedCaptionTextStyle: TextStyle(fontSize: 8),
                  controls: FeedPlayerPortraitControls(
                    videoManager: widget.flickMultiManager,
                    flickManager: flickManager,
                  ),
                  textStyle: commonTextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 8),
                  videoFit: BoxFit.fitWidth,
                ),
                flickVideoWithControlsFullscreen: const FlickVideoWithControls(
                  controls: FlickLandscapeControls(),
                ),
              ),
            ],
          ),
          Container(
            // height: 70,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            color: Colors.white,
            child: Row(
              children: [
                Container(
                  height: 40,
                  child: Material(
                    shape: CircleBorder(),
                    clipBehavior: Clip.antiAlias,
                    child: Image.network(widget.videoData!.coverPicture),
                  ),
                ),
                Text(widget.videoData!.title,style: commonTextStyle(),)
              ],
            ),
          ),
        ],
      )),
    );
  }
}
