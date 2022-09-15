
class PhotoModel {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;

  PhotoModel({this.albumId, this.id, this.title, this.url, this.thumbnailUrl});

  PhotoModel.fromJson(dynamic json) {
    albumId = json['albumId'];
    id = json['id'];
    title = json['title'];
    url = json['url'];
    thumbnailUrl = json['thumbnailUrl'];
  }
  
}
