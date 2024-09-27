import 'package:bloc/bloc.dart';

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

class TripleBloc<A, S, E> extends Bloc<A, State<E, S>> {
  TripleBloc([S? init]) : super(StateInit<E, S>(init)) {
    on<A>(_onAction);
  }

  handle<I extends A>(Function(I event, Emitter<State<E, S>> emit) callback) {
    on<I>((I event, Emitter<State<E, S>> emit) {
      callback(event, emit);
    });
  }

  setError(error) {
    return StateError(error as E);
  }

  setState(S state) {
    return StateSuccess(state);
  }

  setLoading() {
    return StateLoading();
  }

  Future<void> _onAction(A event, Emitter<State<E, S>> emit,
      {S Function(A event, Emitter<State<E, S>> emit)? callback}) async {
    try {
      emit(StateLoading());
      final StateSuccess<E, S> user = StateSuccess(callback!.call(event, emit));
      emit(user);
    } catch (e, stackTrace) {
      emit(StateError<E, S>(e as E));
    }
  }
}

extension EmitterExt<E, S> on Emitter<State<E, S>> {
  loading() {
    return this(StateLoading());
  }

  init([S? state]) {
    return this(StateInit(state));
  }

  state(S state) {
    return this(StateSuccess(state));
  }

  reset([S? state]) {
    return this(StateInit(state));
  }

  error(error) {
    return this(StateError(error as E));
  }
}
