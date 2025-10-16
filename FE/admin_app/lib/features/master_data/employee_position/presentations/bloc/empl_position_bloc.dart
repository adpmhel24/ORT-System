import 'package:admin_app/features/master_data/employee_position/data/models/employee_position_model.dart';
import 'package:admin_app/features/master_data/employee_position/domain/usecases/get_all_empl_position.dart';
import 'package:admin_app/features/master_data/employee_position/domain/usecases/post_empl_position.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/map_failure_to_message.dart';

part 'empl_position_event.dart';
part 'empl_position_state.dart';

class EmplPositionBloc extends Bloc<EmplPositionEvent, EmplPositionState> {
  final GetAllEmplPositions getAllEmplPosition;
  final PostEmplPosition postEmplPosition;

  EmplPositionBloc(
      {required this.getAllEmplPosition, required this.postEmplPosition})
      : super(EmployeePositionInitialState()) {
    on<FetchAllEmplPositionEvent>(_onFetchAllBp);
    on<PostEmplPositionEvent>(_onPostBp);
  }

  void _onFetchAllBp(
      FetchAllEmplPositionEvent event, Emitter<EmplPositionState> emit) async {
    emit(EmployeePositionLoadingState());

    final result = await getAllEmplPosition(event.queryParams);

    emit(
      result.fold(
        (failure) => EmployeePositionErrorState(mapFailureToMessage(failure)),
        (bpList) => EmployeePositionsLoadedState(bpList),
      ),
    );
  }

  void _onPostBp(
      PostEmplPositionEvent event, Emitter<EmplPositionState> emit) async {
    emit(EmployeePositionLoadingState());

    final result = await postEmplPosition(PostParams(body: event.data));

    emit(
      result.fold(
        (failure) => EmployeePositionErrorState(mapFailureToMessage(failure)),
        (successMessage) => PostEmplPositionSuccessState(successMessage),
      ),
    );
  }
}
