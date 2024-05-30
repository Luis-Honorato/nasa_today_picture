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
        endDate: endDate,
        requisitionsCount: requisitionsCount,
      );

      /// When cannot get pictures, throws an exception to catch pictures
      /// from local cache
      if (pictures.isLeft()) {
        throw Exception();
      }

      /// when success, save recieved pictures in cache.
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

  /// Save new pictures in cache
  _saveInCache(
    List<PictureEntity> pictures,
    int requisitionsCount,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final currentPictures = await _getInCache();

    final List<PictureEntity> allPictures = [];

    /// Add new pictures in list
    allPictures.addAll(pictures);

    /// when alredy exists pictures in cache, add in new cache list
    if (currentPictures.isNotEmpty && requisitionsCount > 0) {
      allPictures.addAll(currentPictures);
    }

    /// Adaptate picturesList to String, to could save in cache.
    final jsonPictures = jsonEncode(PictureAdapter.toJson(allPictures));

    /// Save in cache all loaded pictures
    prefs.setString(_picturesCacheKey, jsonPictures);
  }

  /// Get saved pictures in cache
  Future<List<PictureEntity>> _getInCache() async {
    final prefs = await SharedPreferences.getInstance();

    /// Get pictures saved in cache
    final picturesJsonString = prefs.getString(_picturesCacheKey);

    /// Adaptate String into picturesJson.
    /// When hasn't pictures in cache, returns an empty list.
    final picturesJson = (jsonDecode(picturesJsonString ?? '[]') as List)
        .cast<Map<String, dynamic>>();

    /// Adaptate picturesJson into picturesList.
    final pictures = PictureAdapter.fromJson(picturesJson);

    return pictures;
  }
}
