import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:video_player_assignment/componets/player_view.dart';
import 'package:video_player_assignment/pages/video_list/controller/video_list_controller.dart';
import 'package:video_player_assignment/utils/enums.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoListScreen extends GetView<VideoListController> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: Container(
            margin: EdgeInsets.only(left: 10),
            child: SvgPicture.asset('assets/images/logo.svg')),
        leadingWidth: 100,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.cast_rounded,
                color: Colors.black,
              )),
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
                color: Colors.black,
              ))
        ],
      ),
      body: Obx(() => controller.viewState.value == ViewState.LOADING_STATE
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : VisibilityDetector(
              key: ObjectKey(controller.videoManager),
              onVisibilityChanged: (visibility) {
                if (visibility.visibleFraction == 0) {
                  controller.videoManager.pause();
                }
              },
              child: Container(
                child: ListView.builder(
                  itemCount: controller.totalCount.value+(controller.isLoadMore.value?1:0),
                  itemBuilder: (context, index) {
                    if (index == controller.videoData.value.length) {
                      controller.videoManager.pause();
                      controller.getVideoListData();
                    }
                    return index == controller.videoData.value.length
                        ? Container(
                            height: MediaQuery.of(context).size.height * .15,
                            child: const Center(
                              child: CircularProgressIndicator(),
                            ),
                          )
                        : PlayerView(
                            flickMultiManager: controller.videoManager,
                            videoData: controller.videoData.value[index],
                          );
                  },
                ),
              ),
            )),
    );
  }
}
