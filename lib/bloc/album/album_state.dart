
import 'package:cypress_test/model/album_model.dart';

abstract class AlbumState {}

class AlbumLoading extends AlbumState {
  AlbumLoading();
}

class AlbumFetchSuccess extends AlbumState {
  final AlbumModel albumModel ;
  bool deleteMode = false;

  AlbumFetchSuccess(this.albumModel, {this.deleteMode =false});
}

class AlbumError extends AlbumState {
  String error;
  AlbumError(this.error);
}