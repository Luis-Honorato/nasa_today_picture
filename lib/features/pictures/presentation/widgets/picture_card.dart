import 'package:flutter/material.dart';
import 'package:nasa_today_picture/features/pictures/domain/entities/picture.dart';
import 'package:nasa_today_picture/features/pictures/presentation/widgets/image_widget.dart';

class PictureCard extends StatelessWidget {
  final PictureEntity picture;
  const PictureCard({
    super.key,
    required this.picture,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        fit: StackFit.expand,
        children: [
          ImageWidget(url: picture.url),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                color: Colors.black,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  picture.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                color: Colors.black,
                padding: const EdgeInsets.only(
                  right: 8,
                  top: 3,
                  bottom: 3,
                ),
                alignment: Alignment.bottomRight,
                child: Text(
                  picture.date,
                  style: const TextStyle(
                    fontSize: 10,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
