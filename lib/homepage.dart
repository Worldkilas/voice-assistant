import 'package:flutter/material.dart';
import 'package:flutter_voice_assistant/components/chat_bubble.dart';
import 'package:flutter_voice_assistant/components/feature_box.dart';
import 'package:flutter_voice_assistant/components/voice_assistant_image.dart';
import 'package:flutter_voice_assistant/pallete.dart';
import 'package:flutter_voice_assistant/service/openai_service.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SpeechToText speechToText =
      SpeechToText(); //getting access to the speech to text object
  bool speechEnabled =
      false; //a flag to know whether the speech to text has been initialized/enabled
  OpenAiService openAiService = OpenAiService();

  String lastWords = '';
  @override
  void initState() {
    super.initState();
    initSpeechToText();
  }

  Future<void> initSpeechToText() async {
    speechEnabled = await speechToText.initialize();
    // print(speechEnabled);
    setState(() {});
  }

  /// Each time to start a speech recognition session
  Future<void> startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    setState(() {});
  }

  /// Manually stop the active speech recognition session
  /// Note that there are also timeouts that each platform enforces
  /// and the SpeechToText plugin supports setting timeouts on the
  /// listen method.
  Future<void> stopListening() async {
    await speechToText.stop();
    setState(() {});
  }

  /// This is the callback that the SpeechToText plugin calls when
  /// the platform returns recognized words.
  void onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      lastWords = result.recognizedWords;
      // print("Recognized Words: $lastWords");
    });
  }

  @override
  void dispose() {
    speechToText.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alphie'),
        centerTitle: true,
        leading: const Icon(Icons.menu),
      ),
      body: Column(
        children: [
          // assistant's image
          const Assistant(),

          //chat bubble
          const ChatBubble(),

          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(left: 20, top: 10),
            child: const Text(
              'Here are a few features',
              style: TextStyle(
                  fontFamily: 'Cera Pro',
                  color: Pallete.mainFontColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ),
          ),

          //Features list
          const Column(
            children: [
              FeatureBox(
                color: Pallete.firstSuggestionBoxColor,
                headerText: 'ChatGPT',
                descriptionText:
                    'A smarter way to stay organized and well informed with ChatGPT',
              ),
              FeatureBox(
                color: Pallete.secondSuggestionBoxColor,
                headerText: 'Dall-E',
                descriptionText:
                    'Get inspired and stay creative with your personal assistant powered by Dall-E',
              ),
              FeatureBox(
                color: Pallete.thirdSuggestionBoxColor,
                headerText: 'Smart Voice Assistant',
                descriptionText:
                    'Get the best of both worlds with a voice assistant powered by ChatGPT and Dall-E',
              )
            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Pallete.firstSuggestionBoxColor,
        onPressed: () async {
          //when the button is pressed and speech to text is not listening and has permission from the device
          if (await speechToText.hasPermission && speechToText.isNotListening) {
            await startListening();
          } else if (speechToText.isListening) {
            await openAiService.isArtPromptAPI(lastWords);
            //if it is already listening, then it should stop listening when the button is pressed
            await stopListening();
          } else {
            initSpeechToText();
          }
        },
        child: const Icon(Icons.mic),
      ),
    );
  }
}
