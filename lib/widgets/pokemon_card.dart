import 'package:flutter/material.dart';

import '../models/pokemon_model.dart';

class PokemonCard extends StatelessWidget {
  final PokemonModel pokemon;
  final VoidCallback onPlaySound;
  final bool tocandoSom;

  const PokemonCard({
    super.key,
    required this.pokemon,
    required this.onPlaySound,
    required this.tocandoSom,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.07),
            blurRadius: 25,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // TOPO
          Container(
            width: double.infinity,
            height: 115,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFFFFEBEE),
                  Color(0xFFFFCDD2),
                ],
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: Stack(
              children: [
                const Positioned(
                  left: 24,
                  bottom: 20,
                  child: Text(
                    'POKÉMON',
                    style: TextStyle(
                      color: Color(0xFFE53935),
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 18,
                  child: Text(
                    '#${pokemon.id.toString().padLeft(3, '0')}',
                    style: TextStyle(
                      color: Colors.red.shade200,
                      fontSize: 36,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // IMAGEM
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 230,
                height: 230,
                decoration: const BoxDecoration(
                  color: Color(0xFFF7F7F7),
                  shape: BoxShape.circle,
                ),
              ),

              Image.network(
                pokemon.image,
                height: 250,
                width: 250,
                fit: BoxFit.contain,
                errorBuilder:
                    (context, error, stackTrace) {
                  return const Icon(
                    Icons.image_not_supported,
                    size: 80,
                    color: Colors.grey,
                  );
                },
              ),
            ],
          ),

          // NOME
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                Text(
                  pokemon.name.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFFEBEE),
                    borderRadius:
                        BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Pokémon #${pokemon.id.toString().padLeft(3, '0')}',
                    style: const TextStyle(
                      color: Color(0xFFE53935),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                // ÁUDIO
                SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: ElevatedButton.icon(
                    onPressed:
                        tocandoSom ? null : onPlaySound,
                    icon: Icon(
                      tocandoSom
                          ? Icons.graphic_eq_rounded
                          : Icons.volume_up_rounded,
                    ),
                    label: Text(
                      tocandoSom
                          ? 'Reproduzindo...'
                          : 'Tocar som do Pokémon',
                    ),
                    style:
                        ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFE53935),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor:
                          Colors.red.shade200,
                      disabledForegroundColor:
                          Colors.white,
                      elevation: 4,
                      shape:
                          RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(18),
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 26),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
