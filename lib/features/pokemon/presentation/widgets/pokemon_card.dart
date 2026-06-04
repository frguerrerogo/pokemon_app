// features/pokemon/presentation/widgets/pokemon_card.dart
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/utils.dart' show GetStringUtils;
import 'package:pokemon_app/core/core.dart';
import 'package:pokemon_app/features/pokemon/domain/domain.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    required this.pokemon,
    required this.onTap,
    super.key,
  });

  final PokemonEntity pokemon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppBorderRadius.card,
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: AppBorderRadius.card,
          border: Border.all(color: context.colorScheme.outline),
        ),
        child: Row(
          children: [
            _PokemonImage(imageUrl: pokemon.imageUrl),
            Expanded(child: _PokemonInfo(pokemon: pokemon)),
            _PokemonId(id: pokemon.id),
          ],
        ),
      ),
    );
  }
}

class _PokemonImage extends StatelessWidget {
  const _PokemonImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: double.infinity,
      decoration: BoxDecoration(
        color: context.colorScheme.primary.withAlpha(15),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(AppSpacing.xs),
          bottomLeft: Radius.circular(AppSpacing.xs),
        ),
      ),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        placeholder: (_, __) => const Center(
          child: PokeballLoading(),
        ),
        errorWidget: (_, __, ___) => Icon(
          Icons.catching_pokemon_rounded,
          color: context.colorScheme.primary,
          size: AppSpacing.iconLg,
        ),
      ),
    );
  }
}

class _PokemonInfo extends StatelessWidget {
  const _PokemonInfo({required this.pokemon});

  final PokemonEntity pokemon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            pokemon.name.capitalizeFirst ?? '',
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

class _PokemonId extends StatelessWidget {
  const _PokemonId({required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.md),
      child: Text(
        '#${id.toString().padLeft(3, '0')}',
        style: context.typography.bodyMedium?.copyWith(
          color: context.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
