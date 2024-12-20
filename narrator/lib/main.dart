import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'dart:developer';

void main() {
  runApp(const NarratorApp());
}

class NarratorApp extends StatelessWidget {
  const NarratorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NarratorScreen(),
    );
  }
}

class NarratorScreen extends StatefulWidget {
  const NarratorScreen({Key? key}) : super(key: key);

  @override
  NarratorScreenState createState() => NarratorScreenState();
}

class NarratorScreenState extends State<NarratorScreen> {
  final TextEditingController _textController = TextEditingController();
  final FlutterTts _flutterTts = FlutterTts();
  final stt.SpeechToText _speechToText = stt.SpeechToText();
  bool _isListening = false;
  String _recognizedText = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Narrator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textController,
              maxLines: 5,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter text to narrate',
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _speakText,
              child: const Text('Narrate Text'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _listenToSpeech,
              child: Text(_isListening ? 'Stop Listening' : 'Speak to Text'),
            ),
            const SizedBox(height: 16),
            if (_recognizedText.isNotEmpty)
              Text(
                'Recognized Text: $_recognizedText',
                style: const TextStyle(fontSize: 16),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _speakText() async {
    String text = _textController.text;
    if (text.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please enter some text')),
        );
      }
      return;
    }
    await _flutterTts.speak(text);
  }

  Future<void> _listenToSpeech() async {
    if (_isListening) {
      await _speechToText.stop();
      setState(() => _isListening = false);
    } else {
      bool available = await _speechToText.initialize(
        onStatus: (status) => log('Speech Status: $status'),
        onError: (error) => log('Speech Error: $error'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speechToText.listen(onResult: (result) {
          setState(() {
            _recognizedText = result.recognizedWords;
            _textController.text = _recognizedText;
          });
        });
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Speech recognition not available')),
          );
        }
      }
    }
  }

  @override
  void dispose() {
    _flutterTts.stop();
    _speechToText.stop();
    super.dispose();
  }
}