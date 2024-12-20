import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:translator/translator.dart';

enum TtsState { playing, stopped, paused, continued }

class TextToAudioController extends GetxController {
  late FlutterTts flutterTts;
  final translator = GoogleTranslator(client: ClientType.siteGT);
  TextEditingController controller = TextEditingController(
      // text: 'Hello kusal how are you how can i help you?',
      );

  final formKey = GlobalKey<FormState>();

  var volume = 1.0;
  var pitch = 1.0;
  var rate = 1.0;

  var ttsState = TtsState.stopped;
  var selectedLanguage = 'en-US';
  final languages = [
    {'name': 'English', 'code': 'en-US'},
    {'name': 'नेपाली', 'code': 'hi-IN'},
    // {'name': 'हिन्दी', 'code': 'hi-IN'}
  ];

  @override
  void onInit() {
    super.onInit();
    flutterTts = FlutterTts();
  }

  Future<void> _setTtsParameters() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);
    update();
  }

  speak(String text) async {
    await _setTtsParameters();
    if (text.isNotEmpty) {
      await flutterTts.setLanguage(selectedLanguage);
      await flutterTts.speak(text);
      ttsState = TtsState.playing;
    }
    update();
  }

  stop() async {
    var result = await flutterTts.stop();
    if (result == 1) ttsState = TtsState.stopped;
    update();
  }

  pause() async {
    var result = await flutterTts.pause();
    if (result == 1) ttsState = TtsState.paused;
    update();
  }

  translateToNepali(String text, String language) async {
    try {
      var result = await translator.translate(text, to: language);
      controller.text = result.text;
      log(result.text);
    } catch (e) {
      log("Translation Error: $e");
    }
    update();
  }

  @override
  void onClose() {
    flutterTts.stop();

    super.onClose();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }
}
