import 'package:fpdart/fpdart.dart';
import 'package:sis/core/utils/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef StreamEither<T> = Stream<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
