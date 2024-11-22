import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../models/pokemon_card.dart';

class PokemonDetailScreen extends StatelessWidget {
  final PokemonCard card;

  const PokemonDetailScreen({required this.card});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(card.name)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: card.id,
            child: CachedNetworkImage(imageUrl: card.imageUrl),
          ),
          Text('Artist: ${card.artist ?? "N/A"}'),
          Text('Attacks: ${card.attacks?.map((e) => e['name']).join(", ") ?? "N/A"}'),
          Text('Weaknesses: ${card.weaknesses?.map((e) => e['type']).join(", ") ?? "N/A"}'),
        ],
      ),
    );
  }
}
