import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_today_picture/features/pictures/data/datasource/picture_datasource.dart';
import 'package:nasa_today_picture/features/pictures/data/repository/decorators/picture_cache_repository_decorator.dart';
import 'package:nasa_today_picture/features/pictures/data/repository/picture_repository.dart';
import 'package:nasa_today_picture/features/pictures/domain/usecases/get_pictures_usecase.dart';
import 'package:nasa_today_picture/features/pictures/presentation/bloc/picture_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:nasa_today_picture/features/pictures/presentation/pages/pictures_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Nasa Today Picture',
      theme: ThemeData.dark(
        useMaterial3: true,
      ).copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 44, 44, 44),
      ),
      home: BlocProvider<PictureBloc>(
        create: (context) => PictureBloc(
          getPicturesUsecase: GetPicturesUsecase(
            pictureRepository: PictureCacheRepositoryDecorator(
              PictureRepository(
                datasource: PictureDatasource(client: http.Client()),
              ),
            ),
          ),
        ),
        child: const Scaffold(body: PicturesPage()),
      ),
    );
  }
}
