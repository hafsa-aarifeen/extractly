import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'presentation/home_screen.dart';

void main() {
  runApp(const ProviderScope(child: ExtractlyApp()));
}

class ExtractlyApp extends StatelessWidget {
  const ExtractlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Extractly',
      theme: ThemeData(colorSchemeSeed: Colors.teal, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}
