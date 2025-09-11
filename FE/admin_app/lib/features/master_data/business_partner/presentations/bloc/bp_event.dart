part of 'bp_bloc.dart';

abstract class BpEvent extends Equatable {
  const BpEvent();

  @override
  List<Object?> get props => [];
}

class FetchAllBpEvent extends BpEvent {
  final QueryParams? queryParams;

  const FetchAllBpEvent({this.queryParams});

  @override
  List<Object?> get props => [queryParams];
}

class PostBpEvent extends BpEvent {
  final Map<String, dynamic> data;

  const PostBpEvent(this.data);

  @override
  List<Object?> get props => [data];
}
