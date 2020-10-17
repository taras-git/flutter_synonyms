import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_synonyms/bloc/noun_bloc.dart';
import 'package:flutter_synonyms/data/model/noun_model.dart';

class SynonymsPage extends StatefulWidget {
  @override
  _SynonymsPageState createState() => _SynonymsPageState();
}

class _SynonymsPageState extends State<SynonymsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Synonyms Search"),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 16),
        alignment: Alignment.center,
        child: BlocConsumer<NounBloc, NounState>(
          listener: (context, state) {
            if (state is NounError) {
              Scaffold.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is NounInitial) {
              return buildInitialInput();
            } else if (state is NounLoading) {
              return buildLoading();
            } else if (state is NounLoaded) {
              return buildColumnWithData(state.noun);
            } else {
              return buildInitialInput();
            }
          },
        ),
      ),
    );
  }

  Widget buildInitialInput() {
    return NounInputField();
  }

  Widget buildErrorMessage() {
    return Text("Error");
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Column buildColumnWithData(Noun noun) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        NounInputField(),
        Expanded(
          child: ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: noun.syn.synonyms.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  height: 50,
                  color: index % 2 == 0 ? Colors.grey[200] : Colors.grey[300],
                  child: Text(noun.syn.synonyms[index]),
                );
              }),
        ),
      ],
    );
  }
}

class NounInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50),
          child: TextField(
            onSubmitted: (value) => submitWord(context, value),
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: "Enter a noun",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              suffixIcon: Icon(Icons.search),
            ),
          ),
        ),
      ],
    );
  }

  void submitWord(BuildContext context, String word) {
    final nounBloc = context.bloc<NounBloc>();
    nounBloc.add(GetNouns(word));
  }
}
