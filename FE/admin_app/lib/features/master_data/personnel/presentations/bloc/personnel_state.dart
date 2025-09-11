part of 'personnel_bloc.dart';

abstract class PersonnelState extends Equatable {
  const PersonnelState();

  @override
  List<Object?> get props => [];
}

class PersonnelInitState extends PersonnelState {}

class PersonnelLoadingState extends PersonnelState {}

class PersonnelErrorState extends PersonnelState {
  final String message;

  const PersonnelErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class PersonnelsLoadedState extends PersonnelState {
  final List<PersonnelModel> datas;

  const PersonnelsLoadedState(this.datas);

  @override
  List<Object?> get props => [datas];
}

class PersonnelsPostedSuccess extends PersonnelState {}
