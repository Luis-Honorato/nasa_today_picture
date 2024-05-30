import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:rxdart/rxdart.dart';

/// Timer to denied multiples events in bloc.
///
/// Used in FetchPicturesEvent, to denied multiples requisitions while scrolling.
EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>()
        .call(events.throttle((_) => TimerStream(true, duration)), mapper);
  };
}
