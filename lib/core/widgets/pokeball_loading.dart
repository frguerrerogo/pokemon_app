import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pokemon_app/core/core.dart' show AppImages;

class PokeballLoading extends StatefulWidget {
  const PokeballLoading({super.key, this.size = 40});
  final double size;

  @override
  State<PokeballLoading> createState() => _PokeballLoadingState();
}

class _PokeballLoadingState extends State<PokeballLoading> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    unawaited(_controller.repeat(reverse: true));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: _controller,
      child: Image.asset(
        AppImages.logoPokeball,
        width: widget.size,
        height: widget.size,
      ),
    );
  }
}
