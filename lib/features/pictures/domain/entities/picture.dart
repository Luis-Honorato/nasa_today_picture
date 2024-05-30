import 'package:equatable/equatable.dart';

class PictureEntity extends Equatable {
  final String url;
  final String? hdUrl;
  final String date;
  final String title;
  final String description;
  final String? copyRight;

  const PictureEntity({
    required this.url,
    this.hdUrl,
    required this.date,
    required this.title,
    required this.description,
    this.copyRight,
  });

  @override
  List<Object?> get props {
    return [
      url,
      hdUrl,
      date,
      title,
      description,
      copyRight,
    ];
  }
}
