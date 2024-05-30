import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nasa_today_picture/features/pictures/data/datasource/picture_datasource.dart';
import 'package:nasa_today_picture/features/pictures/data/repository/picture_repository.dart';
import 'package:nasa_today_picture/features/pictures/domain/entities/picture.dart';
import 'package:http/http.dart' as http;

import 'picture_repository_test.mocks.dart';

@GenerateMocks([PictureDatasource])
void main() {
  late final MockPictureDatasource mockDatasource;
  late final PictureRepository repository;

  setUp(() {
    mockDatasource = MockPictureDatasource();
    repository = PictureRepository(datasource: mockDatasource);
  });

  const List<PictureEntity> picturesList = [
    PictureEntity(
      url: 'urlTest1',
      hdUrl: 'hdUrlTest1',
      date: 'dateTest1',
      title: 'titleTest1',
      description: 'descriptionTest1',
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

  const fakePicturesJson = '''
  [
    {
      "date": "dateTest1",
      "explanation": "descriptionTest1",
      "hdurl": "hdUrlTest1",
      "title": "titleTest1",
      "url": "urlTest1",
      "media_type": "image"
    },
    {
      "copyright": "copyRightTest2",
      "date": "dateTest2",
      "explanation": "descriptionTest2",
      "hdurl": "hdUrlTest2",
      "title": "titleTest2",
      "url": "urlTest2",
      "media_type": "image"
    }
  ]''';

  final fakeResponse = http.Response(fakePicturesJson, 200);

  test('Must return a list of quizes when call getPictures method', () async {
    when(mockDatasource.getPictures(
      startDate: anyNamed('startDate'),
      endDate: anyNamed('endDate'),
    )).thenAnswer((realInvocation) async => fakeResponse);

    final responsePictures = await repository.getPictures();
    final pictures = responsePictures.fold((l) => null, (pictures) => pictures);

    expect(pictures![0], equals(picturesList[0]));
    expect(pictures[1], equals(picturesList[1]));
  });
}
