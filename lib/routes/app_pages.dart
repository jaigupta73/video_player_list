import 'package:get/get.dart';
import 'package:video_player_assignment/pages/video_list/binding/video_list_binding.dart';
import 'package:video_player_assignment/pages/video_list/ui/video_list_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.VIDEOPLAYLIST;

  static final routes = [
    GetPage(
      name: _Paths.VIDEOPLAYLIST,
      page: () => VideoListScreen(),
      binding: VideoListBinding(),
    ),
  ];
}
