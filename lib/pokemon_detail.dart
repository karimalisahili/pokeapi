import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'pokemon_card.dart';

class PokemonDetail extends StatefulWidget {
  const PokemonDetail({super.key});

  @override
  _PokemonDetailState createState() => _PokemonDetailState();
}

class _PokemonDetailState extends State<PokemonDetail> {
  Map<String, dynamic>? _pokemonData;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchPokemonData('pikachu');
  }

  void _fetchPokemonData(String pokemonName) async {
    final response = await http
        .get(Uri.parse('https://pokeapi.co/api/v2/pokemon/$pokemonName'));
    if (response.statusCode == 200) {
      final pokemonDetail = json.decode(response.body);
      final Map<String, dynamic> pokemonData = {
        'name': pokemonDetail['name'],
        'imageUrls': [
          pokemonDetail['sprites']['front_default'],
          pokemonDetail['sprites']['back_default'],
          pokemonDetail['sprites']['front_shiny'],
          pokemonDetail['sprites']['back_shiny'],
        ],
        'height': pokemonDetail['height'],
        'weight': pokemonDetail['weight'],
        'types': (pokemonDetail['types'] as List)
            .map((typeInfo) => typeInfo['type']['name'] as String)
            .toList(),
        'abilities': (pokemonDetail['abilities'] as List)
            .map((abilityInfo) => abilityInfo['ability']['name'] as String)
            .toList(),
      };
      setState(() {
        _pokemonData = pokemonData;
      });
    } else {
      setState(() {
        _pokemonData = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pokemon not found')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Enter Pokemon Name',
              border: OutlineInputBorder(),
            ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _fetchPokemonData(_controller.text.toLowerCase());
          },
          child: const Text('Search'),
        ),
        const SizedBox(height: 16.0),
        _pokemonData == null
            ? const Text('No Pokemon data')
            : PokemonCard(
                name: _pokemonData!['name'],
                imageUrls: List<String>.from(_pokemonData!['imageUrls']),
                height: _pokemonData!['height'],
                weight: _pokemonData!['weight'],
                types: List<String>.from(_pokemonData!['types']),
                abilities: List<String>.from(_pokemonData!['abilities']),
              ),
      ],
    );
  }
}
