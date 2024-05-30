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
    DateTime? endDate,
    required int requisitionsCount,
  }) async {
    try {
      late String startDateString;

      /// When endDate is not passed use Current day.
      final requisitionEndDate = endDate ?? DateTime.now();

      /// Defines the start date based on 1 week before endDate.
      final dateDifference =
          requisitionEndDate.subtract(const Duration(days: 7));

      /// Format startDate to format at expected format in API
      startDateString =
          '${dateDifference.year}-${dateDifference.month}-${dateDifference.day}';

      /// Format endDate to format at expected format in API
      final endDateString =
          '${requisitionEndDate.year}-${requisitionEndDate.month}-${requisitionEndDate.day}';

      /// Get response from datasource.
      final response = await datasource.getPictures(
        startDate: startDateString,
        endDate: endDateString,
      );

      /// Encode body from string to List<Map<String,dynamic>>
      final body =
          (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();

      /// Format the body in type List<Map<String,dynamic>>
      /// to a List of PictureEntity
      final pictures = PictureAdapter.fromJson(body);

      /// Return success and picturesList;
      return Right(pictures);
    } catch (e) {
      /// return error with error message
      return Left(ServerFailure(e.toString()));
    }
  }
}
