import 'package:fpdart/fpdart.dart';
import 'package:healthy_medicine_2/core/failure.dart';

typedef FutureEither<T> = Future<Either<Failure, T>>;
typedef FutureVoid = FutureEither<void>;
