import 'package:flutter/material.dart';
import 'package:nasa_today_picture/features/pictures/domain/entities/picture.dart';
import 'package:nasa_today_picture/features/pictures/presentation/widgets/image_widget.dart';

class PictureDetailsPage extends StatelessWidget {
  final PictureEntity picture;
  const PictureDetailsPage({
    super.key,
    required this.picture,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          picture.title,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          ImageWidget(url: picture.url),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    picture.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 5),
                if (picture.copyRight != null) ...[
                  Text(
                    '© ${picture.copyRight}',
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
                Text(
                  picture.date,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 28),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    picture.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
