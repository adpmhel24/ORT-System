part of 'job_order_bloc.dart';

abstract class JobOrderEvent extends Equatable {
  const JobOrderEvent();
  @override
  List<Object?> get props => [];
}

class CreateJobOrderEvent extends JobOrderEvent {
  final Map<String, dynamic> data;
  const CreateJobOrderEvent(this.data);
  @override
  List<Object?> get props => [data];
}

class GetAllJobOrdersEvent extends JobOrderEvent {
  final Map<String, dynamic>? params;
  const GetAllJobOrdersEvent([this.params]);
  @override
  List<Object?> get props => [params];
}

class GetJobOrderByIdEvent extends JobOrderEvent {
  final int id;
  const GetJobOrderByIdEvent(this.id);
  @override
  List<Object?> get props => [id];
}
