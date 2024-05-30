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
        /// when user scroll PicturesList, if hasn't internet don't must
        /// Fetch new Pictures, why it will get in CachePictures, and will
        /// duplicate pictures.
        if (state.requisitionsCount > 0) {
          if (!(await ConnectivityUtils.hasDeviceInternet)) {
            return;
          }
        }

        emit(state.copyWith(
          pictureStatus: RequestStatus.loading,
        ));

        /// Every time user Fetch new pictures, get pictures from week in past.
        final endDate = DateTime.now().subtract(
          Duration(days: 7 * state.requisitionsCount),
        );

        final result = await getPicturesUsecase(
          /// When isin't the frist request, remove the current day from List.
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

      /// Assert at this event can be called one for each 100 miliseconds.
      /// Used to avoid multiple requests while scrolling.
      transformer: throttleDroppable(const Duration(milliseconds: 100)),
    );

    on<ChangeFilterEvent>(
      (event, emit) => emit(state.copyWith(
        selectedFilter: event.selectedFilter,
      )),
    );

    on<FilterListEvent>((event, emit) {
      final label = event.label;

      /// when hasn't label, should be displayed default list.
      if (label.isEmpty) {
        emit(state.copyWith(
          filteredPictures: [...state.pictures],
        ));
        return;
      }
      List<PictureEntity> filteredList = [];

      /// Filter PicturesList according selected filter in state.
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
