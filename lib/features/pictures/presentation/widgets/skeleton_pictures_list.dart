import 'package:flutter/material.dart';
import 'package:nasa_today_picture/features/pictures/presentation/bloc/picture_bloc.dart';

/// Skeleton used to indicate while pictues are loading.
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
            decoration: InputDecoration(
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.search),
                  Padding(
                    padding: const EdgeInsets.only(left: 12.0),
                    child: DropdownMenu(
                      enabled: false,
                      inputDecorationTheme: const InputDecorationTheme(
                        border: InputBorder.none,
                      ),
                      initialSelection: Filtertype.date,
                      width: MediaQuery.sizeOf(context).width / 4,
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(
                          label: 'Date',
                          value: Filtertype.date,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
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
