class AlbumModel{
  List<Album>? albums;

  AlbumModel.fromJson(List<dynamic>? json) {
    if (json != null) {
      albums = [];
      for (var e in json) {
        albums!.add(Album.fromJson(e));
      }
    }
  }
}

class Album {
  int? userId;
  int? id;
  String? title;

  Album({this.userId, this.id, this.title});

  Album.fromJson(dynamic json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
  }
}

