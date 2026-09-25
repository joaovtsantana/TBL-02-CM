import 'package:flutter/material.dart';

class PokemonLoading extends StatelessWidget {
  const PokemonLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      child: const Column(
        children: [
          CircularProgressIndicator(
            color: Color(0xFFE53935),
            strokeWidth: 4,
          ),
          SizedBox(height: 20),
          Text(
            'Procurando Pokémon...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
