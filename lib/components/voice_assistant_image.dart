import 'package:flutter/material.dart';
import 'package:flutter_voice_assistant/pallete.dart';

class Assistant extends StatelessWidget {
  const Assistant({super.key});

  @override
  Widget build(BuildContext context) {
    return // Voice assistant image
        Stack(
      //Displays the image of assistant over a circular container
      children: [
        //circular container
        Center(
          child: Container(
            height: 120,
            width: 120,
            margin: const EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Pallete.assistantCircleColor,
            ),
          ),
        ),
        Container(
          height: 125,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(
                  'assets/images/female_avatar.png',
                ),
              )),
        )
      ],
    );
  }
}
