import 'dart:convert';

import 'package:flutter_voice_assistant/secret_key.dart';
import 'package:http/http.dart' as http;

class OpenAiService {
  //determines whether an image/text is to be generated based on the prompts
  //determines whether chatgpt api is to be called or dall-E
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      const String postUrl = 'https://api.openai.com/v1/chat/completions';
      final response = await http.post(Uri.parse(postUrl),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $openAIAPIKey'
          },
          //sends the get request to the api in json format
          body: jsonEncode({
            "model": "gpt-3.5-turbo",
            //this sends the prompt with the user role and the content
            "messages": [
              {
                'role': 'user',
                //USing the content to know whether the user wants to generate an image so I can know which api to contact
                'content':
                    'Does this message want to generate an AI image, picture, art or anything simmilar? $prompt. Reply in either yes or no'
              }
            ]
          }));
      print(response.headers);

      if (response.statusCode == 200) {
        print('YEssir');
      } else {
        print('Network');
      }
      return 'AI';
    } catch (exception) {
      return exception.toString();
    }
  }

  Future<String> chatGPTAPI(String prompt) async => 'ChatGpt';
  Future<String> dallEAPI(String prompt) async => 'Dall-E';
}
