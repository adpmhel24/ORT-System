import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../data/models/vehicle_model.dart';
import '../../domain/usecases/get_all_vehicle.dart';
import '../../domain/usecases/post_vehicle.dart';

part 'vehicle_event.dart';
part 'vehicle_state.dart';

class VehicleBloc extends Bloc<VehicleEvent, VehicleState> {
  final PostVehicleUC postVehicle;
  final GetAllVehicleUC getAllVehicle;

  VehicleBloc({required this.postVehicle, required this.getAllVehicle})
      : super(VehicleInitState()) {
    on<PostVehicleEvent>(_onPostVehicle);
    on<GetAllVehiclesEvent>(_onGetAllVehicles);
  }

  void _onPostVehicle(
      PostVehicleEvent event, Emitter<VehicleState> emit) async {
    emit(VehicleLoadingState());

    final postOrFail = await postVehicle(PostParams(body: event.data));

    emit(
      postOrFail.fold(
        (failure) => VehicleErrorState(mapFailureToMessage(failure)),
        (_) => VehiclePostedSuccess(),
      ),
    );
  }

  void _onGetAllVehicles(
      GetAllVehiclesEvent event, Emitter<VehicleState> emit) async {
    emit(VehicleLoadingState());

    final postOrFail = await getAllVehicle(event.queryParams);

    emit(
      postOrFail.fold(
        (failure) => VehicleErrorState(mapFailureToMessage(failure)),
        (vehicles) => VehiclesLoadedState(vehicles),
      ),
    );
  }
}
