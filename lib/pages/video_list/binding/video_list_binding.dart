import 'package:get/get.dart';
import 'package:video_player_assignment/controllers/video_controller.dart';
import 'package:video_player_assignment/pages/video_list/controller/video_list_controller.dart';

class VideoListBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(VideoListController());
    Get.put(VideoController());
  }
}
