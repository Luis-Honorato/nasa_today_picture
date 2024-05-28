import 'package:nasa_today_picture/features/pictures/domain/entities/picture.dart';

class PictureAdapter {
  const PictureAdapter._();

  static List<PictureEntity> fromJson(List<Map<String, dynamic>> json) {
    final List<PictureEntity> picturesList = [];
    for (Map<String, dynamic> pictureJson in json) {
      if (pictureJson['media_type'] != 'image') {
        continue;
      }
      picturesList.add(
        PictureEntity(
          url: pictureJson['url'],
          hdUrl: pictureJson['hdurl'],
          date: pictureJson['date'],
          title: pictureJson['title'],
          description: pictureJson['explanation'],
          copyRight: pictureJson['copyright'],
        ),
      );
    }
    return picturesList;
  }
}
