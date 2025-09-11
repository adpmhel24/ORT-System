part of 'job_order_bloc.dart';

abstract class JobOrderState extends Equatable {
  const JobOrderState();

  @override
  List<Object?> get props => [];
}

class JobOrderInitial extends JobOrderState {}

class JobOrderLoading extends JobOrderState {}

class JobOrderPostSuccess extends JobOrderState {
  final String message;
  const JobOrderPostSuccess(this.message);
  @override
  List<Object?> get props => [message];
}

class JobOrderListSuccess extends JobOrderState {
  final List<JobOrderModel> orders;
  const JobOrderListSuccess(this.orders);

  @override
  List<Object?> get props => [orders];
}

class JobOrderDetailSuccess extends JobOrderState {
  final JobOrderModel order;
  const JobOrderDetailSuccess(this.order);

  @override
  List<Object?> get props => [order];
}

class JobOrderFailure extends JobOrderState {
  final String message;
  const JobOrderFailure(this.message);

  @override
  List<Object?> get props => [message];
}
