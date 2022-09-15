

import 'package:cypress_test/bloc/photo/photo_state.dart';
import 'package:cypress_test/model/photo_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../db/db_helper.dart';
import '../../model/album_model.dart';
import '../../network/api_call.dart';
import '../../network/api_services.dart';

class PhotoCubit extends Cubit<PhotoState> {
  PhotoCubit() : super(PhotoLoading());

  fetchPhotos(List<Album> albumModel) async {
    BaseOptions options = BaseOptions(method:'GET',baseUrl: ApiServices.BASE_URL);

    List<dynamic>? response = await DBHelper.getPhotos();

    if(response==null) {
      response = await Future.wait([
        ApiCall.call(url: ApiServices.PHOTOS + '?albumId=' + albumModel[0].id.toString(), options: options)!,
        ApiCall.call(url: ApiServices.PHOTOS + '?albumId=' + albumModel[1].id.toString(), options: options)!,
        ApiCall.call(url: ApiServices.PHOTOS + '?albumId=' + albumModel[2].id.toString(), options: options)!,
        ApiCall.call(url: ApiServices.PHOTOS + '?albumId=' + albumModel[3].id.toString(), options: options)!,
      ]);
      DBHelper.insertPhotos(response);
    }
    if (response != null) {

      Map<int,List<PhotoModel>> photosData = {};
      for (var album in response) {
        List<PhotoModel> modelPhotos = [];
        for(var item in album) {
          modelPhotos.add(PhotoModel.fromJson(item));
        }
        photosData[album[0]['albumId']] = modelPhotos;
      }
      emit(PhotoFetchSuccess(photosData));
    }else {
      emit(PhotoError('Something went wrong'));
    }
  }

}