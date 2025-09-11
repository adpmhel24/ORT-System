part of 'vehicle_bloc.dart';

abstract class VehicleEvent extends Equatable {
  const VehicleEvent();

  @override
  List<Object?> get props => [];
}

class GetAllVehiclesEvent extends VehicleEvent {
  final QueryParams? queryParams;

  const GetAllVehiclesEvent({this.queryParams});

  @override
  List<Object?> get props => [queryParams];
}

class PostVehicleEvent extends VehicleEvent {
  final Map<String, dynamic> data;

  const PostVehicleEvent(this.data);

  @override
  List<Object?> get props => [data];
}

class DeleteVehicleEvent extends VehicleEvent {
  final int id;

  const DeleteVehicleEvent({required this.id});

  @override
  List<Object?> get props => [id];
}

class UpdateVehicleEvent extends VehicleEvent {
  final int id;
  final Map<String, dynamic> data;
  const UpdateVehicleEvent({required this.id, required this.data});
  @override
  List<Object?> get props => [id, data];
}
