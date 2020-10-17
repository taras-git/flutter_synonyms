import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_synonyms/data/model/noun_model.dart';
import 'package:flutter_synonyms/data/noun_repository.dart';
import 'package:meta/meta.dart';

part 'noun_event.dart';
part 'noun_state.dart';

class NounBloc extends Bloc<NounEvent, NounState> {
  final NounRepository _nounRepository;

  NounBloc(this._nounRepository) : super(NounInitial());

  @override
  Stream<NounState> mapEventToState(NounEvent event) async* {
    if (event is GetNouns) {
      try {
        yield NounLoading();
        final nouns = await _nounRepository.fetchWords(event.word);
        if (nouns == null) {
          yield NounError("Couldn't fetch words. Is the device online?");
        } else {
          yield NounLoaded(nouns);
        }
      } on NetworkException {
        yield NounError("Couldn't fetch words. Is the device online?");
      }

    }
  }
}
