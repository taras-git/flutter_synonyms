part of 'noun_bloc.dart';

@immutable
abstract class NounEvent {}

class GetNouns extends NounEvent {
  final String word;

  GetNouns(this.word);
}
