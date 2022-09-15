
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../bloc/album/album-cubit.dart';
import '../bloc/album/album_state.dart';
import '../bloc/photo/photo_cubit.dart';
import '../bloc/photo/photo_state.dart';
import '../model/album_model.dart';
import '../resources/widget/photo_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  List<Album> albumModel = [];
  late AlbumCubit _albumCubit;


  @override
  Widget build(BuildContext context) {
    Color commonColor = Colors.red;
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Gallery',style: TextStyle(color: Colors.orange,fontSize: 16),),
      ),
        body: BlocBuilder<AlbumCubit, AlbumState>(builder: (context, state) {
          /// Loading State
          if (state is AlbumLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          /// Success State
          else if (state is AlbumFetchSuccess) {
            albumModel.addAll(state.albumModel.albums!);
            BlocProvider.of<PhotoCubit>(context).fetchPhotos(albumModel);

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                padding: EdgeInsets.all(0),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    int albumId = albumModel[index%4].id!;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(albumModel[index%4].title??'Album'),
                          BlocBuilder<PhotoCubit, PhotoState>(
                              builder: (context, state){
                                if (state is PhotoLoading) {
                                  return const SizedBox(
                                      height: 100,
                                      child: Center(child: CircularProgressIndicator()));
                                } else if (state is PhotoFetchSuccess) {
                                  return Container(
                                    height: 100,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (BuildContext context, int index) {
                                          return Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10)
                                            ),
                                            // key: UniqueKey(),
                                            padding: const EdgeInsets.symmetric(vertical: 5),
                                            height: size.height / 4,
                                            width: size.width / 3.2,
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                                child: PhotoWidget(state.photoModel[albumId]![index % 3].thumbnailUrl ?? '',)),
                                          );
                                        }),
                                  );

                                }
                                else{
                                  return const Center(child: Text('No Image'));
                                }
                              }),
                        ],
                      ),
                    );
                  }),
            );
          }
          else {
            return  Center(child: Text((state as AlbumError).error));
          }
        })
    );
  }

  @override
  void didChangeDependencies() {
    _albumCubit = BlocProvider.of<AlbumCubit>(context);
    _albumCubit.fetchAlbums();
    super.didChangeDependencies();
  }
}
