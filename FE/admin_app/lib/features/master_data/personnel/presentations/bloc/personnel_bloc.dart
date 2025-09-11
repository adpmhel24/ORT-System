import 'package:admin_app/core/usecases/usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/map_failure_to_message.dart';
import '../../data/models/personnel_model.dart';
import '../../domain/usecases/create_personnel.dart';
import '../../domain/usecases/get_all_personnel.dart';

part 'personnel_event.dart';
part 'personnel_state.dart';

class PersonnelBloc extends Bloc<PersonnelEvent, PersonnelState> {
  final CreatePersonnelUC createPersonnel;
  final GetAllPersonnelUC getAllPersonnel;
  PersonnelBloc({required this.createPersonnel, required this.getAllPersonnel})
      : super(PersonnelInitState()) {
    on<PostPersonnel>(_onPostPersonnel);
    on<GetAllPersonnels>(_onGetAllPersonnels);
  }

  void _onPostPersonnel(
      PostPersonnel event, Emitter<PersonnelState> emit) async {
    emit(PersonnelLoadingState());

    final postOrFail = await createPersonnel(PostParams(body: event.data));

    emit(
      postOrFail.fold(
        (failure) => PersonnelErrorState(mapFailureToMessage(failure)),
        (_) => PersonnelsPostedSuccess(),
      ),
    );
  }

  void _onGetAllPersonnels(
      GetAllPersonnels event, Emitter<PersonnelState> emit) async {
    emit(PersonnelLoadingState());

    final postOrFail = await getAllPersonnel(QueryParams(event.queryParams));

    emit(
      postOrFail.fold(
        (failure) => PersonnelErrorState(mapFailureToMessage(failure)),
        (drivers) => PersonnelsLoadedState(drivers),
      ),
    );
  }
}
