import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_today_picture/features/pictures/presentation/bloc/picture_bloc.dart';
import 'package:nasa_today_picture/features/pictures/presentation/widgets/picture_card.dart';
import 'package:nasa_today_picture/features/pictures/presentation/widgets/pictures_list_form_filed.dart';

class PicturesList extends StatelessWidget {
  const PicturesList({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 18.0,
            vertical: 12,
          ),
          child: PicturesListFormField(),
        ),
        Expanded(
          child: BlocBuilder<PictureBloc, PictureState>(
            // buildWhen: (previous, current) =>
            //     previous.filteredPictures != current.filteredPictures,
            builder: (context, state) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                physics: const BouncingScrollPhysics(),
                itemCount: state.filteredPictures.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12.0,
                      vertical: 8,
                    ),
                    child: PictureCard(picture: state.filteredPictures[index]),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
