/// Abstract base class for application use cases.
///
/// [T] represents the return type and [Params]
/// represents the input parameters required
/// to execute the use case.
abstract class UseCase<T, Params> {
  Future<T> call(Params params);
}

class NoParams {}
