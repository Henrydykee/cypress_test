
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/album/album-cubit.dart';
import '../bloc/photo/photo_cubit.dart';

class MultiProvider {
  static List<BlocProvider> providers = [
    BlocProvider<AlbumCubit>(create: (context) => AlbumCubit()),
    BlocProvider<PhotoCubit>(create: (context) => PhotoCubit()),
  ];
}