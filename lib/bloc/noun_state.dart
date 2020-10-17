part of 'noun_bloc.dart';

@immutable
abstract class NounState {
  const NounState();
}

class NounInitial extends NounState {
  const NounInitial();
}

class NounLoading extends NounState {
  const NounLoading();
}

class NounLoaded extends NounState {
//  final Weather weather;
  final Noun noun;

  const NounLoaded(this.noun);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NounLoaded && o.noun == noun;
  }

  @override
  int get hashCode => noun.hashCode;
}

class NounError extends NounState {
  final String message;
  const NounError(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is NounError && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
