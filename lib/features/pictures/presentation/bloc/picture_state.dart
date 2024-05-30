part of 'picture_bloc.dart';

enum Filtertype {
  title,
  date,
}

class PictureState extends Equatable {
  final RequestStatus pictureStatus;
  final List<PictureEntity> pictures;
  final List<PictureEntity> filteredPictures;
  final Filtertype selectedFilter;
  final int requisitionsCount;
  const PictureState({
    this.pictureStatus = RequestStatus.initial,
    this.pictures = const [],
    this.filteredPictures = const [],
    this.selectedFilter = Filtertype.date,
    this.requisitionsCount = 0,
  });

  PictureState copyWith({
    RequestStatus? pictureStatus,
    List<PictureEntity>? pictures,
    List<PictureEntity>? filteredPictures,
    Filtertype? selectedFilter,
    int? requisitionsCount,
  }) {
    return PictureState(
      pictureStatus: pictureStatus ?? this.pictureStatus,
      pictures: pictures ?? this.pictures,
      filteredPictures: filteredPictures ?? this.filteredPictures,
      selectedFilter: selectedFilter ?? this.selectedFilter,
      requisitionsCount: requisitionsCount ?? this.requisitionsCount,
    );
  }

  @override
  List<Object> get props => [
        pictureStatus,
        pictures,
        filteredPictures,
        selectedFilter,
        requisitionsCount,
      ];
}
