part of 'empl_position_bloc.dart';

abstract class EmplPositionEvent extends Equatable {
  const EmplPositionEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllEmplPositionEvent extends EmplPositionEvent {
  final QueryParams? queryParams;

  const FetchAllEmplPositionEvent({this.queryParams});

  @override
  List<Object?> get props => [queryParams];
}

class PostEmplPositionEvent extends EmplPositionEvent {
  final Map<String, dynamic> data;

  const PostEmplPositionEvent(this.data);

  @override
  List<Object?> get props => [data];
}
