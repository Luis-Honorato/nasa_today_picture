import 'package:flutter_test/flutter_test.dart';
import 'package:nasa_today_picture/features/pictures/data/adapter/picture_adapter.dart';
import 'package:nasa_today_picture/features/pictures/domain/entities/picture.dart';

void main() {
  late final List<PictureEntity> picturesList;
  late final List<Map<String, dynamic>> fakePicturesJson;
  setUpAll(() {
    picturesList = const [
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

    fakePicturesJson = [
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
      },
    ];
  });

  test('Must return a Picture when call fromJson method', () {
    final pictures = PictureAdapter.fromJson(fakePicturesJson);

    expect(pictures[0], equals(picturesList[0]));
    expect(pictures[1], equals(picturesList[1]));
  });

  test('Must return a PictureJson when call toJson method', () {
    final picturesJson = PictureAdapter.toJson(picturesList);

    expect(picturesJson.first, equals(fakePicturesJson.first));
    expect(picturesJson.last, equals(fakePicturesJson.last));
  });
}
