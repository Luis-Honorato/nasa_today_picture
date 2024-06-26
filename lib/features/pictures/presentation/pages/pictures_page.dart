import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nasa_today_picture/features/pictures/presentation/bloc/picture_bloc.dart';
import 'package:nasa_today_picture/features/pictures/presentation/widgets/failure_widget.dart';
import 'package:nasa_today_picture/features/pictures/presentation/widgets/pictures_list.dart';
import 'package:nasa_today_picture/features/pictures/presentation/widgets/skeleton_pictures_list.dart';
import 'package:nasa_today_picture/utils/request_status.dart';

class PicturesPage extends StatefulWidget {
  const PicturesPage({super.key});

  @override
  State<PicturesPage> createState() => _PicturesPageState();
}

class _PicturesPageState extends State<PicturesPage> {
  late final PictureBloc pictureBloc;
  @override
  void initState() {
    super.initState();
    pictureBloc = BlocProvider.of<PictureBloc>(context)
      ..add(
        const FetchPicturesEvent(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PictureBloc, PictureState>(
      bloc: pictureBloc,

      /// Assert at Pictures page will be rebuilded only when requisition status
      /// of FetchPictures change.
      buildWhen: (previous, current) =>
          previous.pictureStatus != current.pictureStatus,
      builder: (context, state) {
        if (state.pictureStatus == RequestStatus.failure) {
          return FailureWidget(
            errorMessage: 'Was not possible load pictures, click to try again',
            retryFunction: () => pictureBloc.add(const FetchPicturesEvent()),
          );
        }

        if (state.pictureStatus == RequestStatus.loading ||
            state.pictureStatus == RequestStatus.initial) {
          if (state.pictures.isNotEmpty) {
            return const SafeArea(
              child: PicturesList(),
            );
          }
          return const SafeArea(
            child: SkeletonPicturesList(),
          );
        }
        if (state.pictures.isEmpty) {
          return FailureWidget(
            errorMessage:
                'Hello There was not possible to load pictures, click to try again',
            retryFunction: () => pictureBloc.add(const FetchPicturesEvent()),
          );
        }
        return const SafeArea(
          child: PicturesList(),
        );
      },
    );
  }
}
