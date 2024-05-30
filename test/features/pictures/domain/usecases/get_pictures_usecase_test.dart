import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_today_picture/features/pictures/domain/entities/picture.dart';
import 'package:nasa_today_picture/features/pictures/domain/repository/picture_repository.dart';
import 'package:nasa_today_picture/features/pictures/domain/usecases/get_pictures_usecase.dart';

import 'get_pictures_usecase_test.mocks.dart';

@GenerateMocks([IPictureRepository])
void main() {
  late final MockIPictureRepository mockRepository;
  late final GetPicturesUsecase getPicturesUsecase;

  setUp(() {
    mockRepository = MockIPictureRepository();
    getPicturesUsecase = GetPicturesUsecase(pictureRepository: mockRepository);
  });

  test('Must return a list of Picture when call usecase', () async {
    const List<PictureEntity> picturesResponse = [
      PictureEntity(
        url: 'urlTest1',
        hdUrl: 'hdUrlTest1',
        date: 'dateTest1',
        title: 'titleTest1',
        description: 'descriptionTest1',
        copyRight: 'copyRightTest1',
      ),
      PictureEntity(
        url: 'urlTest2',
        hdUrl: 'hdUrlTest2',
        date: 'dateTest2',
        title: 'titleTest2',
        description: 'descriptionTest2',
        copyRight: 'copyRightTest2',
      ),
    ];

    when(mockRepository.getPictures(
            requisitionsCount: anyNamed('requisitionsCount')))
        .thenAnswer((realInvocation) async => const Right(picturesResponse));

    final response = await getPicturesUsecase(requisitionsCount: 1);

    expect(response, equals(const Right(picturesResponse)));
  });
}
