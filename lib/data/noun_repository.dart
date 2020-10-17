import 'dart:convert';

import 'model/noun_model.dart';
import 'package:http/http.dart' as http;


abstract class NounRepository {
  Future<Noun> fetchWords(String word);
}

class HttpNounRepository implements NounRepository {

  @override
  Future<Noun> fetchWords(String word) async{
    Noun noun;
    String accessToken = "415f2e5dcbfb48fb7f88fd801eac0680";

    var response = await http.get("https://words.bighugelabs.com/api/2/$accessToken/$word/json");

    try {
      if (response.statusCode != 200) {
        throw NetworkException;
      }
      var decodedJson = jsonDecode(response.body);
      noun = Noun.fromJson(decodedJson);

    } catch (err) {
      print(err);
    }
    return noun;
  }
}

class NetworkException implements Exception {}
