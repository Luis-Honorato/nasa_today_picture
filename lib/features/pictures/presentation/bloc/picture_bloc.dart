import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:nasa_today_picture/features/pictures/domain/entities/picture.dart';
import 'package:nasa_today_picture/features/pictures/domain/usecases/get_pictures_usecase.dart';
import 'package:nasa_today_picture/utils/connectivity_utils.dart';
import 'package:nasa_today_picture/utils/request_status.dart';
import 'package:nasa_today_picture/utils/thottle_droppable_transformer.dart';

part 'picture_event.dart';
part 'picture_state.dart';

class PictureBloc extends Bloc<PictureEvent, PictureState> {
  final GetPicturesUsecase getPicturesUsecase;
  PictureBloc({
    required this.getPicturesUsecase,
  }) : super(const PictureState()) {
    on<FetchPicturesEvent>(
      (event, emit) async {
        if (state.requisitionsCount > 0) {
          if (!(await ConnectivityUtils.hasDeviceInternet)) {
            return;
          }
        }

        emit(state.copyWith(
          pictureStatus: RequestStatus.loading,
        ));

        final endDate = DateTime.now().subtract(
          Duration(days: 7 * state.requisitionsCount),
        );

        final result = await getPicturesUsecase(
          startDate: event.startDate,
          endDate: state.requisitionsCount == 0
              ? endDate
              : endDate.subtract(
                  Duration(days: state.requisitionsCount),
                ),
          requisitionsCount: state.requisitionsCount,
        );

        result.fold(
          (failure) {
            emit(state.copyWith(
              pictureStatus: RequestStatus.failure,
            ));
          },
          (pictures) {
            emit(state.copyWith(
              pictureStatus: RequestStatus.success,
              pictures: [...state.pictures, ...pictures.reversed],
              filteredPictures: [...state.pictures, ...pictures.reversed],
              requisitionsCount: state.requisitionsCount + 1,
            ));
          },
        );
      },
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );

    on<ChangeFilterEvent>(
      (event, emit) => emit(state.copyWith(
        selectedFilter: event.selectedFilter,
      )),
    );

    on<FilterListEvent>((event, emit) {
      final label = event.label;
      if (label.isEmpty) {
        emit(state.copyWith(
          filteredPictures: [...state.pictures],
        ));
        return;
      }
      List<PictureEntity> filteredList = [];

      filteredList = state.pictures
          .where(
            (picture) => state.selectedFilter == Filtertype.date
                ? picture.date.toLowerCase().contains(label.toLowerCase())
                : picture.title.toLowerCase().contains(label.toLowerCase()),
          )
          .toList();
      emit(state.copyWith(
        filteredPictures: [...filteredList],
      ));
    });
  }
}
