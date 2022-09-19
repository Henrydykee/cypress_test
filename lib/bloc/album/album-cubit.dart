
import 'package:cypress_test/db/db_helper.dart';
import 'package:cypress_test/model/album_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../network/api_call.dart';
import '../../network/api_services.dart';
import 'album_state.dart';

class AlbumCubit extends Cubit<AlbumState> {
  AlbumCubit() : super(LoadingAlbum());

  fetchAlbums() async {
    List<dynamic>? response;
    response = await DBHelper.getAlbum();
    if(response==null) {
      BaseOptions options = BaseOptions(method: 'GET', baseUrl: ApiServices.BASE_URL);
      response = await ApiCall.call(url: ApiServices.ALBUMS, options: options);
      DBHelper.insertAlbum(response);
    }
    if (response != null) {
      emit(AlbumFetchSuccess(AlbumModel.fromJson(response)));
    }else {
      emit(AlbumError('Something went wrong'));
    }

  }

}