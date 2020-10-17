import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_synonyms/bloc/noun_bloc.dart';
import 'package:flutter_synonyms/data/noun_repository.dart';
import 'package:flutter_synonyms/pages/synonyms_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: BlocProvider(
        create: (context) => NounBloc(HttpNounRepository()),
        child: SynonymsPage(),
      ),
    );
  }
}
