sealed class State<E, T> {
  const State();
}

class StateInit<E, T> extends State<E, T> {
  const StateInit([this.state]);

  final T? state;
}

class StateLoading<E, T> extends State<E, T> {}

class StateError<E, T> extends State<E, T> {
  const StateError(this.exception);

  final E exception;
}

class StateSuccess<E, T> extends State<E, T> {
  const StateSuccess(this.state);

  final T state;
}
