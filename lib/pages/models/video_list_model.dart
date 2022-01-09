class VideoListModel {
  VideoListModel({
    required this.totalItems,
    required this.data,
  });
  late final int totalItems;
  late final List<Data> data;

  VideoListModel.fromJson(Map<String, dynamic> json){
    totalItems = json['total_items'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['total_items'] = totalItems;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Data {
  Data({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.coverPicture,
  });
  late final int id;
  late final String title;
  late final String videoUrl;
  late final String coverPicture;

  Data.fromJson(Map<String, dynamic> json){
    id = json['id'];
    title = json['title'];
    videoUrl = json['videoUrl'];
    coverPicture = json['coverPicture'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['title'] = title;
    _data['videoUrl'] = videoUrl;
    _data['coverPicture'] = coverPicture;
    return _data;
  }
}