import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/usecases/usecase.dart';
import '../../../../../core/utils/map_failure_to_message.dart';
import '../../data/models/bp_model.dart';
import '../../domain/usecases/get_all_bp.dart';
import '../../domain/usecases/post_bp.dart';

part 'bp_event.dart';
part 'bp_state.dart';

class BpBloc extends Bloc<BpEvent, BpState> {
  final GetAllBpUC getAllBp;
  final PostBpUC postBp;

  BpBloc({required this.getAllBp, required this.postBp})
      : super(BpInitialState()) {
    on<FetchAllBpEvent>(_onFetchAllBp);
    on<PostBpEvent>(_onPostBp);
  }

  void _onFetchAllBp(FetchAllBpEvent event, Emitter<BpState> emit) async {
    emit(BpLoadingState());

    final result = await getAllBp(event.queryParams);

    emit(
      result.fold(
        (failure) => BpErrorState(mapFailureToMessage(failure)),
        (bpList) => BpsLoadedState(bpList),
      ),
    );
  }

  void _onPostBp(PostBpEvent event, Emitter<BpState> emit) async {
    emit(BpLoadingState());

    final result = await postBp(PostParams(body: event.data));

    emit(
      result.fold(
        (failure) => BpErrorState(mapFailureToMessage(failure)),
        (successMessage) => PostBpSuccessState(successMessage),
      ),
    );
  }
}
