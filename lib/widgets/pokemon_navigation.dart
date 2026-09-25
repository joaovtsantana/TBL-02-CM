import 'package:flutter/material.dart';

class PokemonNavigation extends StatelessWidget {
  final VoidCallback? onPrevious;
  final VoidCallback onNext;

  const PokemonNavigation({
    super.key,
    required this.onPrevious,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 60,
            child: ElevatedButton.icon(
              onPressed: onPrevious,
              icon: const Icon(
                Icons.arrow_back_rounded,
                size: 25,
              ),
              label: const Text('Anterior'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor:
                    const Color(0xFF333333),
                disabledBackgroundColor:
                    Colors.grey.shade200,
                disabledForegroundColor:
                    Colors.grey.shade400,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                  side: BorderSide(
                    color: Colors.grey.shade300,
                  ),
                ),
              ),
            ),
          ),
        ),

        const SizedBox(width: 14),

        Expanded(
          child: SizedBox(
            height: 60,
            child: ElevatedButton.icon(
              onPressed: onNext,
              icon: const Icon(
                Icons.arrow_forward_rounded,
                size: 25,
              ),
              label: const Text('Próximo'),
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color(0xFFE53935),
                foregroundColor: Colors.white,
                elevation: 4,
                shadowColor:
                    Colors.red.withOpacity(0.3),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
