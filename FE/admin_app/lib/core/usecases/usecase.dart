import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../errors/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

class PostParams extends Equatable {
  final Map<String, dynamic> body;

  const PostParams({required this.body});

  @override
  List<Object> get props => [body];
}

class UpdateParams extends Equatable {
  final String id;
  final Map<String, dynamic> data;

  const UpdateParams({required this.id, required this.data});

  @override
  List<Object> get props => [data, id];
}

class CancelParams extends Equatable {
  final int id;
  final Map<String, dynamic> data;

  const CancelParams({required this.id, required this.data});

  @override
  List<Object> get props => [data, id];
}

class QueryParams extends Equatable {
  final Map<String, dynamic>? data;

  const QueryParams(this.data);

  @override
  List<Object?> get props => [data];
}

class PathParams extends Equatable {
  final Object data;

  const PathParams(this.data);

  @override
  List<Object?> get props => [data];
}
