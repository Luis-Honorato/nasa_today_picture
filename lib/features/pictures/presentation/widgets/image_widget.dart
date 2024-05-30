import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

/// Used to display an Netwwork Image, and chache it in device.
class ImageWidget extends StatelessWidget {
  final String url;
  const ImageWidget({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Image(
      fit: BoxFit.cover,
      image: CachedNetworkImageProvider(
        url,
      ),
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) {
          return child;
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
