import 'package:dartz/dartz.dart';
import 'package:nasa_today_picture/features/pictures/data/repository/picture_repository.dart';
import 'package:nasa_today_picture/features/pictures/domain/entities/picture.dart';
import 'package:nasa_today_picture/features/pictures/domain/repository/picture_repository.dart';
import 'package:nasa_today_picture/utils/failures.dart';

class PictureRepositoryDecorator implements IPictureRepository {
  final PictureRepository pictureRepository;

  PictureRepositoryDecorator(this.pictureRepository);

  @override
  Future<Either<Failure, List<PictureEntity>>> getPictures({
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    return await pictureRepository.getPictures(
      startDate: startDate,
      endDate: endDate,
    );
  }
}
