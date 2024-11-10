import 'package:flutter/material.dart';

class PokemonCard extends StatefulWidget {
  final String name;
  final List<String> imageUrls;
  final int height; // in decimeters
  final int weight; // in hectograms
  final List<String> types;
  final List<String> abilities;

  const PokemonCard({
    super.key,
    required this.name,
    required this.imageUrls,
    required this.height,
    required this.weight,
    required this.types,
    required this.abilities,
  });

  @override
  _PokemonCardState createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  int _currentImageIndex = 0;

  void _showNextImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex + 1) % widget.imageUrls.length;
    });
  }

  void _showPreviousImage() {
    setState(() {
      _currentImageIndex = (_currentImageIndex - 1 + widget.imageUrls.length) %
          widget.imageUrls.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double heightInMeters = widget.height / 10;
    final double weightInKilograms = widget.weight / 10;

    return Card(
      elevation: 4.0,
      margin: const EdgeInsets.all(16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 150, // Set the desired width
              height: 150, // Set the desired height
              child: Image.network(
                widget.imageUrls[_currentImageIndex],
                fit: BoxFit.cover, // Use BoxFit to scale the image
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _showPreviousImage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(
                      Icons.arrow_left,
                      color: Colors.white,
                    ),
                  ),
                  onHover: (hovering) {
                    setState(() {
                      // Change color on hover
                    });
                  },
                ),
                const SizedBox(width: 16.0),
                InkWell(
                  onTap: _showNextImage,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    child: const Icon(
                      Icons.arrow_right,
                      color: Colors.white,
                    ),
                  ),
                  onHover: (hovering) {
                    setState(() {
                      // Change color on hover
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Text(
              widget.name,
              style:
                  const TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  const TextSpan(
                    text: 'Height: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${heightInMeters.toStringAsFixed(1)} m',
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  const TextSpan(
                    text: 'Weight: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${weightInKilograms.toStringAsFixed(1)} kg',
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  const TextSpan(
                    text: 'Types: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: widget.types.join(', '),
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                style: DefaultTextStyle.of(context).style,
                children: [
                  const TextSpan(
                    text: 'Abilities: ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: widget.abilities.join(', '),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
