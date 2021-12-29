export 'Handler.dart';

import 'dart:io';

import 'package:shelf/shelf.dart';

import 'Combinator.dart';
import 'WordChecker.dart';


Response index(Request request) {
  final indexFile = File('templates/index.html').readAsStringSync();
  return Response.ok(
      indexFile,
      headers: {'content-type': 'text/html'}
  );
}

Future<Response> words(Request request, String text) async {
  var resultFile = File('templates/result.html').readAsStringSync();
  String allowedCharacters = 'abcdefghijklmnopqrstuvwxyz';
  text = text.toLowerCase();
  String symbols = [for (var l in text.split('')) if (allowedCharacters.contains(l)) l].join('');

  Combinator combinator = Combinator();
  WordChecker wordChecker = WordChecker();

  Set<String> pseudoWords = combinator.combine("", symbols);
  Set<String> words = await wordChecker.getWords(pseudoWords);

  resultFile = resultFile.replaceAll('\${{result}}', words.join('   '));
  resultFile = resultFile.replaceAll('\${{result}}', text);
  return Response.ok(
    resultFile,
    headers: {'content-type': 'text/html'}
  );
}