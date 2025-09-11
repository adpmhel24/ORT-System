part of 'personnel_bloc.dart';

abstract class PersonnelEvent extends Equatable {
  const PersonnelEvent();
  @override
  List<Object?> get props => [];
}

class PostPersonnel extends PersonnelEvent {
  final Map<String, dynamic> data;

  const PostPersonnel(this.data);
  @override
  List<Object?> get props => [data];
}

class GetAllPersonnels extends PersonnelEvent {
  final Map<String, dynamic>? queryParams;

  const GetAllPersonnels([this.queryParams]);

  @override
  List<Object?> get props => [queryParams];
}
