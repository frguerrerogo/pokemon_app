// features/pokemon/presentation/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pokemon_app/app/app.dart' show AppRoutes;
import 'package:pokemon_app/core/core.dart';
import 'package:pokemon_app/features/pokemon/presentation/controllers/home_controller.dart';
import 'package:pokemon_app/features/pokemon/presentation/presentation.dart'
    show HomeStatus, PokemonCard, PokemonListSkeleton;

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.onPrimary,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AppBar(controller: controller),
            const _OfflineBanner(),
            Expanded(child: _Body(controller: controller)),
          ],
        ),
      ),
    );
  }
}

class _AppBar extends StatelessWidget {
  const _AppBar({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.screenHorizontal,
        vertical: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.homeTitle,
                style: context.typography.displaySmall?.copyWith(
                  color: context.colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                context.l10n.homeSubtitle,
                style: context.typography.bodySmall?.copyWith(
                  color: context.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          _LogoutButton(controller: controller),
        ],
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  const _LogoutButton({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: context.l10n.logout,
      child: InkWell(
        onTap: () => _confirmLogout(context, controller),
        borderRadius: AppBorderRadius.brFull,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            shape: BoxShape.circle,
            border: Border.all(color: context.colorScheme.outline),
          ),
          child: Icon(
            Icons.logout_rounded,
            color: context.colorScheme.onSurfaceVariant,
            size: AppSpacing.iconMd,
          ),
        ),
      ),
    );
  }

  Future<void> _confirmLogout(BuildContext context, HomeController controller) async {
    await showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: context.colorScheme.surface,
        shape: const RoundedRectangleBorder(borderRadius: AppBorderRadius.card),
        title: Text(
          context.l10n.logout,
          style: context.typography.titleMedium?.copyWith(
            color: context.colorScheme.onSurface,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          context.l10n.homeLogoutMessage,
          style: context.typography.bodyMedium?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back<void>(),
            child: Text(
              context.l10n.cancel,
              style: TextStyle(color: context.colorScheme.onSurfaceVariant),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              Get.back<void>();
              controller.logout();
              await Get.offAllNamed<void>(AppRoutes.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: context.colors.error,
              shape: const RoundedRectangleBorder(
                borderRadius: AppBorderRadius.button,
              ),
              elevation: 0,
            ),
            child: Text(
              context.l10n.logout,
              style: TextStyle(color: context.colorScheme.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}

class _OfflineBanner extends GetView<HomeController> {
  const _OfflineBanner();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.state.value.isOffline) return const SizedBox.shrink();

      return Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
          vertical: AppSpacing.sm,
        ),
        color: context.colors.warning.withAlpha(30),
        child: Row(
          children: [
            Icon(
              Icons.wifi_off_rounded,
              size: AppSpacing.iconSm,
              color: context.colors.warning,
            ),
            const SizedBox(width: AppSpacing.xs),
            Text(
              context.l10n.homeOfflineMessage,
              style: context.typography.bodySmall?.copyWith(
                color: context.colors.warning,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    });
  }
}

class _Body extends StatelessWidget {
  const _Body({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final state = controller.state.value;

      switch (state.status) {
        case HomeStatus.initial:
        case HomeStatus.loading:
          return const _LoadingState();

        case HomeStatus.error:
          return _ErrorState(controller: controller);

        case HomeStatus.success:
          return _SuccessState(controller: controller);
      }
    });
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.screenHorizontal),
      child: PokemonListSkeleton(),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.screenHorizontal),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.cloud_off_rounded,
              size: 64,
              color: context.colorScheme.onSurfaceVariant.withAlpha(100),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              context.l10n.homeErrorTitle,
              style: context.typography.titleMedium?.copyWith(
                color: context.colorScheme.onSurface,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              controller.state.value.errorMessage,
              style: context.typography.bodyMedium?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl2),
            SizedBox(
              width: double.infinity,
              height: AppSpacing.buttonHeightMd,
              child: ElevatedButton.icon(
                onPressed: controller.refresh,
                icon: const Icon(Icons.refresh_rounded),
                label: Text(context.l10n.retry),
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  foregroundColor: context.colorScheme.onPrimary,
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppBorderRadius.button,
                  ),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessState extends StatelessWidget {
  const _SuccessState({required this.controller});

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.refresh,
      color: context.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.screenHorizontal,
        ),
        child: Obx(
          () => ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            itemCount: controller.state.value.pokemons.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (_, index) {
              final pokemon = controller.state.value.pokemons[index];
              return PokemonCard(
                pokemon: pokemon,
                onTap: () => controller.goToDetail(pokemon),
              );
            },
          ),
        ),
      ),
    );
  }
}
