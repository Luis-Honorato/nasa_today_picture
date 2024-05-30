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
  const PictureState({
    this.pictureStatus = RequestStatus.initial,
    this.pictures = const [],
    this.filteredPictures = const [],
    this.selectedFilter = Filtertype.date,
  });

  PictureState copyWith({
    RequestStatus? pictureStatus,
    List<PictureEntity>? pictures,
    List<PictureEntity>? filteredPictures,
    Filtertype? selectedFilter,
  }) {
    return PictureState(
      pictureStatus: pictureStatus ?? this.pictureStatus,
      pictures: pictures ?? this.pictures,
      filteredPictures: filteredPictures ?? this.filteredPictures,
      selectedFilter: selectedFilter ?? this.selectedFilter,
    );
  }

  @override
  List<Object> get props => [
        pictureStatus,
        pictures,
        filteredPictures,
        selectedFilter,
      ];
}
