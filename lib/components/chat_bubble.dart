import 'package:flutter/material.dart';
import 'package:flutter_voice_assistant/pallete.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: const EdgeInsets.symmetric(horizontal: 35).copyWith(top: 30),
      decoration: BoxDecoration(
          border: Border.all(color: Pallete.borderColor),
          borderRadius:
              BorderRadius.circular(20).copyWith(topLeft: Radius.zero)),
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Text(
          'Good Morning, what can I do for you?',
          style: TextStyle(
              color: Pallete.mainFontColor,
              fontSize: 25,
              fontFamily: 'Cera Pro'),
        ),
      ),
    );
  }
}
