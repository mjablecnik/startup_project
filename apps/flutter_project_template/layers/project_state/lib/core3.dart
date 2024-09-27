class StateInit<E, S> extends State<E, S> {
  const StateInit([S? state]) : super(data: state);
}

class StateLoading<E, S> extends State<E, S> {
  const StateLoading() : super(isLoading: true);
}

class StateError<E, S> extends State<E, S> {
  const StateError(E e) : super(error: e);
}

class StateSuccess<E, S> extends State<E, S> {
  const StateSuccess(S state) : super(data: state);
}

abstract class State<E, S> {
  final bool isLoading;
  final E? error;
  final S? data;

  const State({
    this.isLoading = false,
    this.error,
    this.data,
  });

  factory State.init([S? user]) = StateInit;

  factory State.reset([S? user]) = StateInit;

  factory State.loading() = StateLoading;

  factory State.error(E error) = StateError;

  factory State.success(S user) = StateSuccess;
}
