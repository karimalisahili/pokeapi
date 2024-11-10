import 'package:flutter/material.dart';
import 'pokemon_detail.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: PokemonDetail(),
        ),
      ),
    );
  }
}