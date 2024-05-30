part of 'picture_bloc.dart';

enum Filtertype {
  title,
  date,
}

class PictureState extends Equatable {
  /// Requisition Status of FetchPicturesEvent
  final RequestStatus pictureStatus;

  /// All pictures Recieved from API
  final List<PictureEntity> pictures;

  /// Pictures at are displayed for user. is nescessary to filter pictures by
  /// Title or Date.
  final List<PictureEntity> filteredPictures;

  /// User current picture filter.
  ///
  /// By default is date.
  final Filtertype selectedFilter;

  /// Used to count user's requisitions, used to paginate all pictures,
  /// and fetch more according user scrolling.
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
