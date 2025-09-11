part of 'vehicle_bloc.dart';

abstract class VehicleState extends Equatable {
  const VehicleState();

  @override
  List<Object?> get props => [];
}

class VehicleInitState extends VehicleState {}

class VehicleLoadingState extends VehicleState {}

class VehiclesLoadedState extends VehicleState {
  final List<VehicleModel> datas;
  const VehiclesLoadedState(this.datas);
  @override
  List<Object?> get props => [datas];
}

class VehiclePostedSuccess extends VehicleState {}

class VehicleErrorState extends VehicleState {
  final String message;
  const VehicleErrorState(this.message);
  @override
  List<Object?> get props => [message];
}
