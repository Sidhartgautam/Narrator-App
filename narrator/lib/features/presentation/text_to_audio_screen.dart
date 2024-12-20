import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:narrator/core/resources/colors.dart';
import 'package:narrator/core/widgets/custom/custom_button_widget.dart';

import '../../core/widgets/custom/text_fields.dart';
import '../controller/text_to_audio_controller.dart';

class TextToAudioScreen extends StatefulWidget {
  const TextToAudioScreen({super.key});

  @override
  State<TextToAudioScreen> createState() => _TextToAudioScreenState();
}

class _TextToAudioScreenState extends State<TextToAudioScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Get.put(TextToAudioController());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: const Text('Text to Speech'),
      ),
      body: GetBuilder<TextToAudioController>(builder: (ttsC) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: ttsC.formKey,
            child: Column(
              children: [
                PrimaryTextField(
                  minLines: 10,
                  maxLine: 50,
                  onValueChange: (p0) {
                    setState(() {
                      ttsC.controller.text = p0;
                    });
                  },
                  onSubmitted: (p0) {
                    setState(() {
                      ttsC.controller.text = p0;
                    });
                  },
                  border: primaryColor,
                  controller: ttsC.controller,
                  hint: 'Enter Text',
                  textInputAction: TextInputAction.done,
                  textInputType: TextInputType.text,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildButtonColumn(Colors.green, Colors.greenAccent, Icons.play_arrow, 'PLAY',
                        () => ttsC.speak(ttsC.controller.text)),
                    buildButtonColumn(Colors.red, Colors.redAccent, Icons.stop, 'STOP', () {
                      ttsC.stop();
                    }),
                    buildButtonColumn(Colors.blue, Colors.blueAccent, Icons.pause, 'PAUSE', () {
                      ttsC.pause();
                    }),
                  ],
                ),
                DropdownButton<String>(
                  value: ttsC.selectedLanguage,
                  items: ttsC.languages.map((language) {
                    return DropdownMenuItem<String>(
                      value: language['code'],
                      child: Text(language['name']!),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      ttsC.selectedLanguage = value!;
                      if (ttsC.controller.text.isNotEmpty) {
                        String code = '';
                        if (ttsC.selectedLanguage == 'hi-IN' || ttsC.selectedLanguage == 'ne-NP') {
                          code = 'ne';
                        } else if (ttsC.selectedLanguage == 'en-US') {
                          code = 'en';
                        }
                        ttsC.translateToNepali(ttsC.controller.text, code);
                        // }
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
