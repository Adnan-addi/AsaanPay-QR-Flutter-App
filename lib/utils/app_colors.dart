import 'package:flutter/material.dart';

/// Colour tokens transcribed from `AsaanPay QR Light v2.dc.html`.
///
/// The design leans on two families: solid brand hues, and alpha overlays
/// derived from the slate base (#0F172A) or pure white for the glass surfaces.
abstract final class AppColors {
  // Brand
  static const blue = Color(0xFF1E90FF);
  static const blueDeep = Color(0xFF0B72D8);
  static const blueRoyal = Color(0xFF1D4ED8);
  static const teal = Color(0xFF2DD4BF);
  static const tealDeep = Color(0xFF0F766E);

  // Text
  static const ink = Color(0xFF0B1220);
  static const inkSoft = Color(0xFF5B6779);
  static const inkMuted = Color(0xFF6B7688);
  static const inkFaint = Color(0xFF93A0B2);
  static const slate = Color(0xFF334155);
  static const divider = Color(0xFFC3CCD9);

  // Status
  static const warning = Color(0xFFB45309);
  static const danger = Color(0xFFB91C1C);

  // The scanner is the one dark screen in the set.
  static const scanTop = Color(0xFF0E1626);
  static const scanMid = Color(0xFF111C2E);
  static const scanBottom = Color(0xFF0B1322);

  // Surfaces
  static const white = Color(0xFFFFFFFF);
  static const canvas = Color(0xFFEEF2F7);

  /// Fully transparent — for sheets that paint their own frosted background.
  static const transparent = Color(0x00000000);
  static const bgTop = Color(0xFFFFFFFF);
  static const bgMid = Color(0xFFF4F8FD);
  static const bgBottom = Color(0xFFE8EFF9);

  /// Base the design uses for every dark alpha overlay: `rgba(15,23,42,a)`.
  static const _slateBase = Color(0xFF0F172A);

  /// `rgba(15,23,42,<opacity>)`
  static Color slateA(double opacity) => _slateBase.withValues(alpha: opacity);

  /// `rgba(255,255,255,<opacity>)`
  static Color whiteA(double opacity) => white.withValues(alpha: opacity);

  /// `rgba(30,144,255,<opacity>)`
  static Color blueA(double opacity) => blue.withValues(alpha: opacity);

  /// `rgba(45,212,191,<opacity>)`
  static Color tealA(double opacity) => teal.withValues(alpha: opacity);
}

/// Gradients used across the design.
abstract final class AppGradients {
  /// Primary CTA / pill buttons — `linear-gradient(90deg,#1E90FF,#2DD4BF)`.
  static const primary = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [AppColors.blue, AppColors.teal],
  );

  /// Balance card — `linear-gradient(125deg,#1E90FF 0%,#2DD4BF 100%)`.
  static const card = LinearGradient(
    begin: Alignment(-0.82, -1),
    end: Alignment(0.82, 1),
    colors: [AppColors.blue, AppColors.teal],
  );

  /// Avatars / FAB — `linear-gradient(135deg,#1E90FF,#2DD4BF)`.
  static const diagonal = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.blue, AppColors.teal],
  );

  /// The scanner's dark ground.
  static const scanner = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.scanTop, AppColors.scanMid, AppColors.scanBottom],
    stops: [0.0, 0.5, 1.0],
  );

  /// Screen background — white → #F4F8FD at 55% → #E8EFF9.
  static const screen = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [AppColors.bgTop, AppColors.bgMid, AppColors.bgBottom],
    stops: [0.0, 0.55, 1.0],
  );
}
