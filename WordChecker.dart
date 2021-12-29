export 'WordChecker.dart';

import 'dart:collection';
import 'dart:convert';

import 'package:http/http.dart';

class WordChecker {
  final BASE_URL = "https://api.dictionaryapi.dev/api/v2/entries/en/";

  Future<Set<String>> getWords(Set<String> pseudoWords) async {
    var client = Client();
    Set<String> words = {};

    try {
      for (var word in pseudoWords) {
        var response = await client.get(Uri.parse(BASE_URL + word));
        if (response.statusCode == 200) {
          var responseBody = jsonDecode(response.body)[0];
          print(responseBody);
          if (responseBody.containsKey("word")) {
            var definitions = responseBody["meanings"][0]["definitions"][0];
            var definition = definitions["definition"];
            words.add("<strong>" + responseBody["word"] + "<\/strong>" + " - " + definition + "<br><br>");
          }
        }
      }
    } finally {
      client.close();
    }

    return words;
  }
}