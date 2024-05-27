import 'package:dartz/dartz.dart';
import 'package:nasa_today_picture/features/pictures/domain/entities/picture.dart';
import 'package:nasa_today_picture/features/pictures/domain/repository/picture_repository.dart';
import 'package:nasa_today_picture/utils/failures.dart';

class GetPicturesUsecase {
  final IPictureRepository pictureRepository;

  const GetPicturesUsecase({required this.pictureRepository});

  Future<Either<Failure, List<PictureEntity>>> call(
      {DateTime? startDate}) async {
    return await pictureRepository.getPictures(startDate: startDate);
  }
}
