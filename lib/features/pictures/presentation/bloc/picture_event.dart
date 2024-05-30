part of 'picture_bloc.dart';

sealed class PictureEvent extends Equatable {
  const PictureEvent();

  @override
  List<Object> get props => [];
}

/// Used to Fetch new pictures to display to user.
/// Called when user open the PicturesPage, and when user scroll in PicturesList
class FetchPicturesEvent extends PictureEvent {
  const FetchPicturesEvent();
}

/// Used to change current pictures filter.
/// Called when user clicks on PictureListFormField's dropdown
class ChangeFilterEvent extends PictureEvent {
  final Filtertype selectedFilter;

  const ChangeFilterEvent({required this.selectedFilter});
}

/// Used to filter PicturesList based on text user type in PictureListFormField
/// Called when user type an text in PictureListFormField
class FilterListEvent extends PictureEvent {
  final String label;

  const FilterListEvent({required this.label});
}
