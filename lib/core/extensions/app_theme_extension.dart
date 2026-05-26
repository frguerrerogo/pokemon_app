import 'package:flutter/material.dart';
import 'package:pokemon_app/core/theme/app_colors.dart';
import 'package:pokemon_app/core/theme/app_spacing.dart';

extension AppThemeExtension on BuildContext {
  //* THEME
  ThemeData get theme => Theme.of(this);

  bool get isDark => theme.brightness == Brightness.dark;
  bool get isLight => theme.brightness == Brightness.light;

  //* COLORS
  AppColors get colors => isDark ? AppColorScheme.dark : AppColorScheme.light;

  ColorScheme get colorScheme => theme.colorScheme;

  //* TYPOGRAPHY
  TextTheme get typography => theme.textTheme;

  //* RESPONSIVE BREAKPOINTS
  static const double _breakpointTablet = 600;
  static const double _breakpointDesktop = 1200;

  bool get isMobile => MediaQuery.sizeOf(this).width < _breakpointTablet;

  bool get isTablet {
    final width = MediaQuery.sizeOf(this).width;
    return width >= _breakpointTablet && width < _breakpointDesktop;
  }

  bool get isDesktop => MediaQuery.sizeOf(this).width >= _breakpointDesktop;

  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  //* SPACING
  double get screenPaddingH => AppSpacing.screenHorizontal;
  double get screenPaddingV => AppSpacing.screenVertical;
  double get itemGap => AppSpacing.itemGap;
  double get inlineGap => AppSpacing.inlineGap;
}
