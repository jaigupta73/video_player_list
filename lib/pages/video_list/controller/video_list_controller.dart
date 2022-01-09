import 'dart:async';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:video_player_assignment/pages/models/video_list_model.dart';
import 'package:video_player_assignment/utils/enums.dart';
import 'package:video_player_assignment/utils/mock_data.dart';
import 'package:video_player_assignment/video_managers/video_manager.dart';

class VideoListController extends GetxController {
  Rx<ViewState> viewState = ViewState.LOADING_STATE.obs;

  RxBool showLoadMore = false.obs;
  RxBool progressBar = false.obs;
  Connectivity _connectivity = Connectivity();
  PreviousNetStatus _previousNetStatus = PreviousNetStatus.NONE;
  StreamSubscription<ConnectivityResult>? _connectivitySubscription;
  bool _firstTimeNet = true;
  RxList<Data> videoData = <Data>[].obs;
  VideoListModel? videoModel;
  late VideoManager videoManager;
  RxInt totalCount = 0.obs;
  RxInt start = 0.obs, end = 10.obs;
  RxBool isLoadMore = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    videoManager = VideoManager();
    _initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    getVideoListData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _connectivitySubscription?.cancel();
  }

  void onConnected() {}

  void onDisConnected() {}

  Future<void> _initConnectivity() async {
    ConnectivityResult? result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }

    return _updateConnectionStatus(result!);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.CONNECTED) {
            onConnected();
          }
          _previousNetStatus = PreviousNetStatus.CONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.CONNECTED;
          _firstTimeNet = false;
        }
        break;
      case ConnectivityResult.mobile:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.CONNECTED) {
            onConnected();
          }
          _previousNetStatus = PreviousNetStatus.CONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.CONNECTED;
          _firstTimeNet = false;
        }
        break;
      case ConnectivityResult.none:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.DISCONNECTED) {
            onDisConnected();
          }
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
          _firstTimeNet = false;
        }
        break;
      default:
        if (!_firstTimeNet) {
          if (_previousNetStatus != PreviousNetStatus.DISCONNECTED) {
            onDisConnected();
          }
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
        } else {
          _previousNetStatus = PreviousNetStatus.DISCONNECTED;
          _firstTimeNet = false;
        }
        break;
    }
  }

  void getVideoListData() async {
    if (videoModel == null) {
      videoModel = VideoListModel.fromJson(mock_data);
      totalCount.value = videoModel!.totalItems;
    }
    videoData.value
        .addAll(videoModel!.data.getRange(start.value, end.value).toList());
    videoData.refresh();
    if (videoData.value.length < totalCount.value) {
      start.value = start.value + 10;
      end.value = end.value + 10;
      isLoadMore.value = true;
    } else {
      isLoadMore.value = false;
    }
    viewState.value = ViewState.LIST_VIEW_STATE;
  }
}
