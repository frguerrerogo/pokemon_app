import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/core/core.dart';
import 'package:pokemon_app/features/pokemon/presentation/controllers/detail_controller.dart';
import 'package:pokemon_app/features/pokemon/presentation/presentation.dart' show DetailStatus;

class DetailScreen extends GetView<DetailController> {
  const DetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onPrimary,
      appBar: AppBar(
        backgroundColor: context.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: context.colorScheme.onSurface),
          onPressed: Get.back<void>,
        ),
        title: Obx(() {
          final pokemon = controller.state.value.pokemon;
          return Text(
            pokemon?.name.capitalizeFirst ?? 'Pokémon',
            style: context.typography.titleLarge?.copyWith(
              color: context.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          );
        }),
        centerTitle: true,
      ),
      body: Obx(() {
        final state = controller.state.value;

        switch (state.status) {
          case DetailStatus.initial:
          case DetailStatus.loading:
            return const Center(
              child: PokeballLoading(
                size: 150,
              ),
            );

          case DetailStatus.error:
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 64,
                      color: context.colors.error,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      context.l10n.error,
                      style: context.typography.titleMedium?.copyWith(
                        color: context.colorScheme.onSurface,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      state.errorMessage,
                      style: context.typography.bodyMedium?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: AppSpacing.xl2),
                    SizedBox(
                      width: double.infinity,
                      height: AppSpacing.buttonHeightMd,
                      child: ElevatedButton(
                        onPressed: controller.loadPokemonDetail,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: context.colorScheme.primary,
                          shape: const RoundedRectangleBorder(
                            borderRadius: AppBorderRadius.button,
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          context.l10n.retry,
                          style: TextStyle(color: context.colorScheme.onPrimary),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );

          case DetailStatus.success:
            final pokemon = state.pokemon!;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Imagen grande
                  Container(
                    width: double.infinity,
                    height: 300,
                    color: context.colorScheme.primary.withAlpha(15),
                    child: CachedNetworkImage(
                      imageUrl: pokemon.imageUrl,
                      fit: BoxFit.contain,
                      placeholder: (_, __) => const Center(
                        child: PokeballLoading(),
                      ),
                      errorWidget: (_, __, ___) => Icon(
                        Icons.catching_pokemon_rounded,
                        color: context.colorScheme.primary,
                        size: 80,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Nombre y ID
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                pokemon.name.capitalizeFirst ?? '',
                                style: context.typography.displaySmall?.copyWith(
                                  color: context.colorScheme.onSurface,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.md,
                                vertical: AppSpacing.sm,
                              ),
                              decoration: BoxDecoration(
                                color: context.colorScheme.primary.withAlpha(30),
                                borderRadius: AppBorderRadius.card,
                              ),
                              child: Text(
                                '#${pokemon.id.toString().padLeft(3, '0')}',
                                style: context.typography.titleMedium?.copyWith(
                                  color: context.colorScheme.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        // Medidas
                        Row(
                          children: [
                            Expanded(
                              child: _InfoCard(
                                label: context.l10n.height,
                                value: '${pokemon.height.toStringAsFixed(1)} m',
                                context: context,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: _InfoCard(
                                label: context.l10n.weight,
                                value: '${pokemon.weight.toStringAsFixed(1)} kg',
                                context: context,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSpacing.xl),
                        // Stats
                        Text(
                          context.l10n.stats,
                          style: context.typography.titleMedium?.copyWith(
                            color: context.colorScheme.onSurface,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        _StatBar(
                          label: context.l10n.hp,
                          value: pokemon.hp,
                          context: context,
                        ),
                        _StatBar(
                          label: context.l10n.attack,
                          value: pokemon.attack,
                          context: context,
                        ),
                        _StatBar(
                          label: context.l10n.defense,
                          value: pokemon.defense,
                          context: context,
                        ),
                        _StatBar(
                          label: context.l10n.special_attack,
                          value: pokemon.specialAttack,
                          context: context,
                        ),
                        _StatBar(
                          label: context.l10n.special_defense,
                          value: pokemon.specialDefense,
                          context: context,
                        ),
                        _StatBar(
                          label: context.l10n.speed,
                          value: pokemon.speed,
                          context: context,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
        }
      }),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({
    required this.label,
    required this.value,
    required this.context,
  });

  final String label;
  final String value;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        borderRadius: AppBorderRadius.card,
        border: Border.all(color: context.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.typography.bodySmall?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            value,
            style: context.typography.titleMedium?.copyWith(
              color: context.colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatBar extends StatelessWidget {
  const _StatBar({
    required this.label,
    required this.value,
    required this.context,
  });

  final String label;
  final int value;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    const maxStat = 255;
    final percentage = value / maxStat;

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: context.typography.bodySmall?.copyWith(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                value.toString(),
                style: context.typography.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.xs),
            child: LinearProgressIndicator(
              value: percentage,
              minHeight: 8,
              backgroundColor: context.colorScheme.outline.withAlpha(50),
              valueColor: AlwaysStoppedAnimation<Color>(
                context.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
