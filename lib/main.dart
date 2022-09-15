import 'dart:io';

import 'package:cypress_test/provider/list_provider.dart';
import 'package:cypress_test/ui/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiBlocProvider(
        providers: MultiProvider.providers,
        child: const MaterialApp(
          home: HomeScreen(),
          debugShowCheckedModeBanner: false,
        )
    );
  }
}


