import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:narrator/core/widgets/custom/buttons.dart';
import 'package:narrator/features/presentation/text_to_audio_screen.dart';

import '../speech_to_text.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: PrimaryButton(
                  height: 60,
                  label: 'Text to Speech',
                  onPressed: () {
                    Get.to(() => const TextToAudioScreen());
                  }),
            ),
            SizedBox(width: 10),
            Expanded(
              child: PrimaryButton(
                  height: 60,
                  label: 'Speech to Text',
                  onPressed: () {
                    Get.to(() => const SpeechToTextScreen());
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
