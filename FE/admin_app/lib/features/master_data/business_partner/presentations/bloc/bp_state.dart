part of 'bp_bloc.dart';

abstract class BpState extends Equatable {
  const BpState();

  @override
  List<Object?> get props => [];
}

class BpInitialState extends BpState {}

class BpLoadingState extends BpState {}

class BpsLoadedState extends BpState {
  final List<BusinessPartnerModel> datas;

  const BpsLoadedState(this.datas);

  @override
  List<Object?> get props => [datas];
}

class BpErrorState extends BpState {
  final String message;

  const BpErrorState(this.message);

  @override
  List<Object?> get props => [message];
}

class PostBpSuccessState extends BpState {
  final String message;

  const PostBpSuccessState(this.message);

  @override
  List<Object?> get props => [message];
}
