import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../models/pokemon_model.dart';
import '../services/pokemon_service.dart';
import '../widgets/pokemon_card.dart';
import '../widgets/pokemon_loading.dart';
import '../widgets/pokemon_navigation.dart';
import '../widgets/pokemon_search.dart';

class PokemonScreen extends StatefulWidget {
  const PokemonScreen({super.key});

  @override
  State<PokemonScreen> createState() =>
      _PokemonScreenState();
}

class _PokemonScreenState extends State<PokemonScreen> {
  final TextEditingController _controller =
      TextEditingController();

  final AudioPlayer _audioPlayer = AudioPlayer();

  final PokemonService _service =
      PokemonService();

  PokemonModel? pokemon;

  bool carregando = false;
  bool tocandoSom = false;

  String? mensagemErro;

  // ==========================================================
  // INIT STATE
  // ==========================================================

  @override
  void initState() {
    super.initState();

    print('Tela iniciada');

    // Carrega o Pokémon #1 automaticamente.
    buscarPokemon(1);
  }

  // ==========================================================
  // BUSCAR
  // ==========================================================

  Future<void> buscarPokemon(dynamic busca) async {
    FocusScope.of(context).unfocus();

    setState(() {
      carregando = true;
      mensagemErro = null;
      tocandoSom = false;
    });

    try {
      final resultado =
          await _service.buscarPokemon(busca);

      if (!mounted) return;

      setState(() {
        pokemon = resultado;
        carregando = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        carregando = false;
        mensagemErro =
            'Pokémon não encontrado.\n\n'
            'Digite um nome ou número válido.';
      });
    }
  }

  // ==========================================================
  // PESQUISAR
  // ==========================================================

  void pesquisar() {
    final texto = _controller.text.trim();

    if (texto.isEmpty) {
      setState(() {
        mensagemErro =
            'Digite o nome ou número de um Pokémon.';
      });

      return;
    }

    buscarPokemon(texto.toLowerCase());
  }

  // ==========================================================
  // ANTERIOR
  // ==========================================================

  void pokemonAnterior() {
    if (pokemon != null && pokemon!.id > 1) {
      buscarPokemon(pokemon!.id - 1);
    }
  }

  // ==========================================================
  // PRÓXIMO
  // ==========================================================

  void pokemonProximo() {
    if (pokemon != null) {
      buscarPokemon(pokemon!.id + 1);
    }
  }

  // ==========================================================
  // ÁUDIO
  // ==========================================================

  Future<void> tocarSom() async {
    if (pokemon == null) return;

    if (pokemon!.audio.isEmpty) {
      setState(() {
        mensagemErro =
            'Este Pokémon não possui áudio.';
      });

      return;
    }

    try {
      setState(() {
        tocandoSom = true;
      });

      await _audioPlayer.stop();

      await _audioPlayer.play(
        UrlSource(pokemon!.audio),
      );

      await Future.delayed(
        const Duration(milliseconds: 800),
      );

      if (!mounted) return;

      setState(() {
        tocandoSom = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        tocandoSom = false;
        mensagemErro =
            'Não foi possível tocar o som.';
      });
    }
  }

  // ==========================================================
  // DISPOSE
  // ==========================================================

  @override
  void dispose() {
    print('Tela finalizada');

    _controller.dispose();
    _audioPlayer.dispose();

    super.dispose();
  }

  // ==========================================================
  // BUILD
  // ==========================================================

  @override
  Widget build(BuildContext context) {
    print('Tela reconstruída');

    return Scaffold(
      backgroundColor:
          const Color(0xFFF4F5F9),

      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ==================================================
            // HEADER
            // ==================================================

            SliverToBoxAdapter(
              child: Container(
                padding:
                    const EdgeInsets.fromLTRB(
                  24,
                  28,
                  24,
                  32,
                ),
                decoration:
                    const BoxDecoration(
                  gradient:
                      LinearGradient(
                    colors: [
                      Color(0xFFE53935),
                      Color(0xFFC62828),
                    ],
                    begin:
                        Alignment.topLeft,
                    end:
                        Alignment.bottomRight,
                  ),
                  borderRadius:
                      BorderRadius.only(
                    bottomLeft:
                        Radius.circular(38),
                    bottomRight:
                        Radius.circular(38),
                  ),
                ),
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    // LOGO
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          decoration:
                              BoxDecoration(
                            color: Colors.white
                                .withOpacity(0.18),
                            shape:
                                BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons
                                .catching_pokemon,
                            color:
                                Colors.white,
                            size: 32,
                          ),
                        ),

                        const SizedBox(
                          width: 14,
                        ),

                        const Column(
                          crossAxisAlignment:
                              CrossAxisAlignment
                                  .start,
                          children: [
                            Text(
                              'POKÉDEX',
                              style:
                                  TextStyle(
                                color:
                                    Colors.white,
                                fontSize: 25,
                                fontWeight:
                                    FontWeight
                                        .w900,
                                letterSpacing:
                                    2,
                              ),
                            ),
                            Text(
                              'Explore o mundo Pokémon',
                              style:
                                  TextStyle(
                                color:
                                    Colors.white70,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(
                      height: 28,
                    ),

                    const Text(
                      'Encontre seu Pokémon',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 27,
                        fontWeight:
                            FontWeight.w800,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    const Text(
                      'Pesquise pelo nome ou número da Pokédex.',
                      style: TextStyle(
                        color:
                            Colors.white70,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    // PESQUISA
                    PokemonSearch(
                      controller:
                          _controller,
                      onSearch:
                          pesquisar,
                    ),
                  ],
                ),
              ),
            ),

            // ==================================================
            // CONTEÚDO
            // ==================================================

            SliverPadding(
              padding:
                  const EdgeInsets.fromLTRB(
                20,
                24,
                20,
                30,
              ),
              sliver:
                  SliverToBoxAdapter(
                child: _buildContent(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==========================================================
  // CONTEÚDO
  // ==========================================================

  Widget _buildContent() {
    if (carregando) {
      return const PokemonLoading();
    }

    if (mensagemErro != null) {
      return _buildError();
    }

    if (pokemon == null) {
      return const SizedBox();
    }

    return Column(
      children: [
        PokemonCard(
          pokemon: pokemon!,
          onPlaySound: tocarSom,
          tocandoSom: tocandoSom,
        ),

        const SizedBox(height: 18),

        PokemonNavigation(
          onPrevious:
              pokemon!.id > 1
                  ? pokemonAnterior
                  : null,
          onNext:
              pokemonProximo,
        ),

        const SizedBox(height: 18),

        Row(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.swipe,
              size: 17,
              color: Colors.grey,
            ),
            const SizedBox(width: 7),
            Text(
              'Use os botões para navegar',
              style: TextStyle(
                color:
                    Colors.grey.shade600,
                fontSize: 12,
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ==========================================================
  // ERRO
  // ==========================================================

  Widget _buildError() {
    return Container(
      width: double.infinity,
      padding:
          const EdgeInsets.all(30),
      decoration:
          BoxDecoration(
        color: Colors.white,
        borderRadius:
            BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color:
                Colors.black.withOpacity(
              0.05,
            ),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 75,
            height: 75,
            decoration:
                BoxDecoration(
              color: Colors.red.shade50,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.search_off,
              color:
                  Color(0xFFE53935),
              size: 38,
            ),
          ),

          const SizedBox(
            height: 18,
          ),

          const Text(
            'Ops!',
            style: TextStyle(
              fontSize: 26,
              fontWeight:
                  FontWeight.w800,
            ),
          ),

          const SizedBox(
            height: 8,
          ),

          Text(
            mensagemErro!,
            textAlign:
                TextAlign.center,
            style: const TextStyle(
              color: Colors.grey,
              height: 1.5,
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          ElevatedButton.icon(
            onPressed: () {
              _controller.clear();
              buscarPokemon(1);
            },
            icon: const Icon(
              Icons.refresh,
            ),
            label: const Text(
              'Voltar ao início',
            ),
            style:
                ElevatedButton.styleFrom(
              backgroundColor:
                  const Color(
                0xFFE53935,
              ),
              foregroundColor:
                  Colors.white,
              padding:
                  const EdgeInsets
                      .symmetric(
                horizontal: 22,
                vertical: 15,
              ),
              shape:
                  RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(
                  14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
