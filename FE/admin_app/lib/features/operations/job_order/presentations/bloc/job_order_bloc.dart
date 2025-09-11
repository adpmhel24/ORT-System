import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/job_order_model.dart';
import '../../domain/usecases/create_job_order.dart';
import '../../domain/usecases/get_all_job_orders.dart';
import '../../domain/usecases/get_job_order_by_id.dart';

part 'job_order_event.dart';
part 'job_order_state.dart';

class JobOrderBloc extends Bloc<JobOrderEvent, JobOrderState> {
  final CreateJobOrder createJobOrder;
  final GetAllJobOrders getAllJobOrders;
  final GetJobOrderById getJobOrderById;

  JobOrderBloc({
    required this.createJobOrder,
    required this.getAllJobOrders,
    required this.getJobOrderById,
  }) : super(JobOrderInitial()) {
    on<CreateJobOrderEvent>(_onCreateJobOrder);
    on<GetAllJobOrdersEvent>(_onGetAllJobOrders);
    on<GetJobOrderByIdEvent>(_onGetJobOrderById);
  }

  void _onCreateJobOrder(
      CreateJobOrderEvent event, Emitter<JobOrderState> emit) async {
    emit(JobOrderLoading());
    final result = await createJobOrder(event.data);
    result.fold(
      (failure) => emit(JobOrderFailure(failure.message)),
      (message) => emit(JobOrderPostSuccess(message)),
    );
  }

  void _onGetAllJobOrders(
      GetAllJobOrdersEvent event, Emitter<JobOrderState> emit) async {
    emit(JobOrderLoading());
    final result = await getAllJobOrders(event.params);
    result.fold(
      (failure) => emit(JobOrderFailure(failure.message)),
      (orders) => emit(JobOrderListSuccess(orders)),
    );
  }

  void _onGetJobOrderById(
      GetJobOrderByIdEvent event, Emitter<JobOrderState> emit) async {
    emit(JobOrderLoading());
    final result = await getJobOrderById(event.id);
    result.fold(
      (failure) => emit(JobOrderFailure(failure.message)),
      (order) => emit(JobOrderDetailSuccess(order)),
    );
  }
}
