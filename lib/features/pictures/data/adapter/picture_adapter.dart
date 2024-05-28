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

  static List<Map<String, dynamic>> toJson(List<PictureEntity> pictures) {
    final List<Map<String, dynamic>> picturesJson = [];
    for (PictureEntity picture in pictures) {
      picturesJson.add({
        'url': picture.url,
        if (picture.hdUrl != null) 'hdurl': picture.hdUrl,
        'date': picture.date,
        'title': picture.title,
        'explanation': picture.description,
        if (picture.copyRight != null) 'copyright': picture.copyRight,
        'media_type': 'image',
      });
    }

    return picturesJson;
  }
}
