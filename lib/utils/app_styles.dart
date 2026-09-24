import 'package:flutter/widgets.dart';

import 'app_colors.dart';

/// Elevation tokens. The design uses layered, tinted shadows rather than
/// Material elevation, so these are transcribed one-for-one from `box-shadow`.
abstract final class AppShadows {
  /// Primary CTA — `0 10px 28px -4px rgba(30,144,255,.42), 0 2px 12px rgba(45,212,191,.22)`.
  static List<BoxShadow> get cta => [
    BoxShadow(
      color: AppColors.blueA(.42),
      blurRadius: 28,
      spreadRadius: -4,
      offset: const Offset(0, 10),
    ),
    BoxShadow(
      color: AppColors.tealA(.22),
      blurRadius: 12,
      offset: const Offset(0, 2),
    ),
  ];

  /// Balance card — `0 14px 36px -8px rgba(30,144,255,.4), 0 6px 18px -6px rgba(0,0,0,.35)`.
  static List<BoxShadow> get balanceCard => [
    BoxShadow(
      color: AppColors.blueA(.40),
      blurRadius: 36,
      spreadRadius: -8,
      offset: const Offset(0, 14),
    ),
    BoxShadow(
      color: const Color(0xFF000000).withValues(alpha: .35),
      blurRadius: 18,
      spreadRadius: -6,
      offset: const Offset(0, 6),
    ),
  ];

  /// Floating bottom bar — `0 10px 28px rgba(15,23,42,.13)`.
  static List<BoxShadow> get bottomBar => [
    BoxShadow(
      color: AppColors.slateA(.13),
      blurRadius: 28,
      offset: const Offset(0, 10),
    ),
  ];

  /// Centre FAB.
  ///
  /// The design specifies `0 12px 30px -4px rgba(30,144,255,.65)`. CSS spreads
  /// that over a translucent bar; Flutter paints it straight onto the opaque
  /// pill, where the offset plus the strong blue reads as a hard crescent under
  /// the circle. Pulled back and spread wider so it lifts rather than smudges.
  static List<BoxShadow> get fab => [
    BoxShadow(
      color: AppColors.blueA(.38),
      blurRadius: 28,
      spreadRadius: -8,
      offset: const Offset(0, 9),
    ),
    BoxShadow(
      color: AppColors.tealA(.20),
      blurRadius: 14,
      spreadRadius: -4,
      offset: const Offset(0, 3),
    ),
  ];

  /// Small gradient chip — `0 8px 20px -6px rgba(30,144,255,.6)`.
  static List<BoxShadow> get chip => [
    BoxShadow(
      color: AppColors.blueA(.60),
      blurRadius: 20,
      spreadRadius: -6,
      offset: const Offset(0, 8),
    ),
  ];
}

/// Corner radii used by the design.
abstract final class AppRadii {
  static const phone = 44.0;
  static const sheet = 32.0;
  static const card = 28.0;
  static const panel = 26.0;
  static const bubble = 22.0;
  static const tile = 20.0;
  static const field = 18.0;
  static const chip = 16.0;
  static const pill = 14.0;
  static const icon = 13.0;
  static const small = 12.0;
  static const xs = 11.0;
}
