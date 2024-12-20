import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:narrator/features/presentation/text_to_audio_screen.dart';

import 'features/presentation/home/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Narrator App',
      useInheritedMediaQuery: true,
      home: HomePage(),
      themeMode: ThemeMode.light,
    );
  }
}
