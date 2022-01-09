import 'package:flick_video_player/flick_video_player.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:video_player_assignment/pages/models/video_list_model.dart';
import 'package:video_player_assignment/video_managers/video_manager.dart';

class VideoController extends GetxController
{
  late FlickManager flickManager;

  void flickManagerInti(Data data,VideoManager videoManager)
  {
    flickManager = FlickManager(
      videoPlayerController: VideoPlayerController.network(data.videoUrl)
        ..setLooping(true),
      autoPlay: false,
    );
    videoManager.init(flickManager);
  }
}