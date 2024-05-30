import 'package:dartz/dartz.dart';
import 'package:nasa_today_picture/features/pictures/domain/entities/picture.dart';
import 'package:nasa_today_picture/utils/failures.dart';

abstract class IPictureRepository {
  Future<Either<Failure, List<PictureEntity>>> getPictures({
    DateTime? endDate,
    required int requisitionsCount,
  });
}
