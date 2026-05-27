import 'package:flutter/material.dart';
import 'package:pokemon_app/core/core.dart';

class PokemonListSkeleton extends StatefulWidget {
  const PokemonListSkeleton({super.key, this.itemCount = 8});

  final int itemCount;

  @override
  State<PokemonListSkeleton> createState() => _PokemonListSkeletonState();
}

class _PokemonListSkeletonState extends State<PokemonListSkeleton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.4, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (_, __) => ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        itemCount: widget.itemCount,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (_, __) => _SkeletonCard(opacity: _animation.value),
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard({required this.opacity});

  final double opacity;

  @override
  Widget build(BuildContext context) {
    final base = context.colorScheme.onSurface.withAlpha(15);

    return Opacity(
      opacity: opacity,
      child: Container(
        height: 110,
        decoration: BoxDecoration(
          color: base,
          borderRadius: AppBorderRadius.card,
        ),
        child: Row(
          children: [
            // Imagen
            Container(
              width: 100,
              decoration: BoxDecoration(
                color: context.colorScheme.onSurface.withAlpha(25),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSpacing.sm),
                  bottomLeft: Radius.circular(AppSpacing.sm),
                ),
              ),
            ),
            // Info
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 16,
                      width: 120,
                      decoration: BoxDecoration(
                        color: base,
                        borderRadius: AppBorderRadius.brSm,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Container(
                      height: 22,
                      width: 80,
                      decoration: BoxDecoration(
                        color: base,
                        borderRadius: AppBorderRadius.brFull,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
