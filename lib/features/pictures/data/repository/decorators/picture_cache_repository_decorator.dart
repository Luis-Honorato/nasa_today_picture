import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:nasa_today_picture/features/pictures/data/adapter/picture_adapter.dart';
import 'package:nasa_today_picture/features/pictures/data/repository/decorators/picture_repository_decorator.dart';
import 'package:nasa_today_picture/features/pictures/data/repository/picture_repository.dart';
import 'package:nasa_today_picture/features/pictures/domain/entities/picture.dart';
import 'package:nasa_today_picture/utils/failures.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PictureCacheRepositoryDecorator extends PictureRepositoryDecorator {
  PictureCacheRepositoryDecorator(PictureRepository pictureRepository)
      : super(pictureRepository);

  static const String _picturesCacheKey = 'pictures_cache';

  @override
  Future<Either<Failure, List<PictureEntity>>> getPictures({
    DateTime? startDate,
    DateTime? endDate,
    required int requisitionsCount,
  }) async {
    try {
      final pictures = await super.getPictures(
        startDate: startDate,
        endDate: endDate,
        requisitionsCount: requisitionsCount,
      );

      /// When cannot get pictures, throws an exception to catch pictures
      /// from local cache
      if (pictures.isLeft()) {
        throw Exception();
      }
      _saveInCache(
        pictures.fold(
          (l) => [],
          (picturesList) => picturesList,
        ),
        requisitionsCount,
      );
      return pictures;
    } catch (e) {
      final pictures = await _getInCache();
      return Right(pictures);
    }
  }

  _saveInCache(
    List<PictureEntity> pictures,
    int requisitionsCount,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final currentPictures = await _getInCache();
    final List<PictureEntity> allPictures = [];
    allPictures.addAll(pictures);
    if (currentPictures.isNotEmpty && requisitionsCount > 0) {
      allPictures.addAll(currentPictures);
    }
    final jsonPictures = jsonEncode(PictureAdapter.toJson(allPictures));

    prefs.setString(_picturesCacheKey, jsonPictures);
  }

  Future<List<PictureEntity>> _getInCache() async {
    final prefs = await SharedPreferences.getInstance();
    final picturesJsonString = prefs.getString(_picturesCacheKey);
    final picturesJson = (jsonDecode(picturesJsonString ?? '[]') as List)
        .cast<Map<String, dynamic>>();

    final pictures = PictureAdapter.fromJson(picturesJson);

    return pictures;
  }
}
