part of 'picture_bloc.dart';

class PictureState extends Equatable {
  final RequestStatus pictureStatus;
  final List<PictureEntity> pictures;
  const PictureState({
    this.pictureStatus = RequestStatus.initial,
    this.pictures = const [],
  });

  PictureState copyWith({
    RequestStatus? pictureStatus,
    List<PictureEntity>? pictures,
  }) {
    return PictureState(
      pictureStatus: pictureStatus ?? this.pictureStatus,
      pictures: pictures ?? this.pictures,
    );
  }

  @override
  List<Object> get props => [
        pictureStatus,
        pictures,
      ];
}
