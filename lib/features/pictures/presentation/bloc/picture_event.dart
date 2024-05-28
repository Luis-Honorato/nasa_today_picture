part of 'picture_bloc.dart';

sealed class PictureEvent extends Equatable {
  const PictureEvent();

  @override
  List<Object> get props => [];
}

class FetchPicturesEvent extends PictureEvent {
  final DateTime? startDate;

  const FetchPicturesEvent({this.startDate});
}
