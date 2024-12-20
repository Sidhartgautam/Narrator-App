import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:just_audio/just_audio.dart';

/// Entry point of the Flutter application.
void main() {
  runApp(const NarrateApp());
}

/// The main application widget.
class NarrateApp extends StatelessWidget {
  /// Constructor for [NarrateApp].
  const NarrateApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _NarrationScreen(),
    );
  }
}

/// A screen that allows users to input text and generate a narration.
class _NarrationScreen extends StatefulWidget {
  /// Constructor for [_NarrationScreen].
  const _NarrationScreen({Key? key}) : super(key: key);

  @override
  _NarrationScreenState createState() => _NarrationScreenState();
}

class _NarrationScreenState extends State<_NarrationScreen> {
  /// Controller for the text input field.
  final TextEditingController _textController = TextEditingController();

  /// The currently selected language for narration.
  ///
  /// Defaults to English ('en').
  String _selectedLanguage = 'en';

  /// Indicates whether the narration is being generated.
  bool _isLoading = false;

  /// The URL of the generated audio file.
  String? _audioUrl;

  /// The audio player for playing narrations.
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Text Narrator'),
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
                labelText: 'Paste your text here',
              ),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedLanguage,
              onChanged: (value) {
                setState(() {
                  _selectedLanguage = value!;
                });
              },
              items: const [
                DropdownMenuItem(value: 'en', child: Text('English')),
                DropdownMenuItem(value: 'ne', child: Text('Nepali')),
              ],
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _generateNarration,
                    child: const Text('Narrate'),
                  ),
            if (_audioUrl != null)
              ElevatedButton(
                onPressed: _playAudio,
                child: const Text('Play Narration'),
              ),
          ],
        ),
      ),
    );
  }

  /// Sends a request to generate narration for the provided text and language.
  ///
  /// Displays a loading indicator while processing and handles errors gracefully.
  Future<void> _generateNarration() async {

    Dio dio = Dio();
    final text = _textController.text;
    if (text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter some text')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final response = await dio.post(
       'http://127.0.0.1:8000/narrate/', // Replace with your backend URL
       data: {
         'text': text,
         'language': _selectedLanguage,
       },
       options: Options(
         headers: {
           'Content-Type': 'application/json',
         },
       )
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);
        setState(() {
          _audioUrl = data['file_path'];
        });
      } else {
        throw Exception('Failed to generate narration');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  /// Plays the generated narration audio using the [AudioPlayer].
  void _playAudio() async {
    if (_audioUrl != null) {
      await _audioPlayer.setUrl(_audioUrl!);
      _audioPlayer.play();
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
