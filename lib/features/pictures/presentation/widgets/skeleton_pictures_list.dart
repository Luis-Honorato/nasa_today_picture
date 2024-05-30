import 'package:flutter/material.dart';

class SkeletonPicturesList extends StatelessWidget {
  const SkeletonPicturesList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 12,
          ),
          child: TextFormField(
            enabled: false,
            decoration: const InputDecoration(
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12.0,
                  vertical: 8,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(
                        color: Colors.grey.withOpacity(0.4),
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: 10,
          ),
        ),
      ],
    );
  }
}
