import 'package:flutter/material.dart';
import 'package:wordle/features/random_word/presentation/page/random_word_page.dart';

import 'injection_container.dart' as di;

Future<void> main() async {
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: RandomWordPage(),
    );
  }
}
