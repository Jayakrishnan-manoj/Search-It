import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:search_it/env/env.dart';

Future<String> generateResponse(String prompt) async {
  final apiKey = Env.openAi_key;
  var url = Uri.https("api.openai.com", "/v1/completions");
  final response = await http.post(url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey'
      },
      body: jsonEncode({
        'model': "text-davinci-003",
        'prompt': prompt,
        'temperature': 0,
        'max_tokens': 300,
      }));
  print(response.body);

  Map<String, dynamic> newResponse = jsonDecode(response.body);
  print(newResponse);
  return newResponse['choices'][0]['text'];
}
