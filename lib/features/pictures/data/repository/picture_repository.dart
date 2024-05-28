import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:nasa_today_picture/features/pictures/data/adapter/picture_adapter.dart';
import 'package:nasa_today_picture/features/pictures/data/datasource/picture_datasource.dart';
import 'package:nasa_today_picture/features/pictures/domain/entities/picture.dart';
import 'package:nasa_today_picture/features/pictures/domain/repository/picture_repository.dart';
import 'package:nasa_today_picture/utils/failures.dart';

class PictureRepository implements IPictureRepository {
  final PictureDatasource datasource;

  const PictureRepository({required this.datasource});

  @override
  Future<Either<Failure, List<PictureEntity>>> getPictures({
    DateTime? startDate,
  }) async {
    try {
      /// Create a default value of StartDate when is null
      late String startDateString;
      if (startDate == null) {
        final dateDifference = DateTime.now().subtract(const Duration(days: 7));
        startDateString =
            '${dateDifference.year}-${dateDifference.month}-${dateDifference.day}';
      } else {
        startDateString =
            '${startDate.year}-${startDate.month}-${startDate.day}';
      }
      final response = await datasource.getPictures(startDate: startDateString);

      final body =
          (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();

      final pictures = PictureAdapter.fromJson(body);

      return Right(pictures);
    } catch (_) {
      return const Left(ServerFailure(''));
    }
  }
}