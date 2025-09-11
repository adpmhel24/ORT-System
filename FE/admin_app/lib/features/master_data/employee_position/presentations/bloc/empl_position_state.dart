part of 'empl_position_bloc.dart';

abstract class EmplPositionState extends Equatable {
  const EmplPositionState();

  @override
  List<Object?> get props => [];
}

class EmployeePositionInitialState extends EmplPositionState {}

class EmployeePositionLoadingState extends EmplPositionState {}

class EmployeePositionsLoadedState extends EmplPositionState {
  final List<EmployeePositionModel> datas;

  const EmployeePositionsLoadedState(this.datas);

  @override
  List<Object?> get props => [datas];
}

class EmployeePositionErrorState extends EmplPositionState {
  final String message;

  const EmployeePositionErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class PostEmplPositionSuccessState extends EmplPositionState {
  final String message;

  const PostEmplPositionSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}
