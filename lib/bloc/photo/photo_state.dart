

import 'package:cypress_test/model/photo_model.dart';

abstract class PhotoState {}

class LoadingPhotos extends PhotoState {
  LoadingPhotos();
}

class PhotoFetchSuccess extends PhotoState {
  final Map<int,List<PhotoModel>> photoModel ;

  PhotoFetchSuccess(this.photoModel);
}

class PhotoError extends PhotoState {
  String error;
  PhotoError(this.error);
}