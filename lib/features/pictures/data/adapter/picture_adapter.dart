import 'package:nasa_today_picture/features/pictures/domain/entities/picture.dart';

class PictureAdapter {
  const PictureAdapter._();

  static List<PictureEntity> fromJson(List<Map<String, dynamic>> json) {
    return json
        .map(
          (pictureJson) => PictureEntity(
            url: pictureJson['url'],
            hdUrl: pictureJson['hdurl'],
            date: pictureJson['date'],
            title: pictureJson['title'],
            description: pictureJson['explanation'],
            copyRight: pictureJson['copyright'],
          ),
        )
        .toList();
  }
}
