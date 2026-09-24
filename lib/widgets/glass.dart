import 'dart:ui';

import 'package:flutter/widgets.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';

/// The frosted panel the design uses for nearly every surface:
/// `background:rgba(255,255,255,.7); border:1px solid rgba(15,23,42,.07);
/// backdrop-filter:blur(26px)`.
class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.radius = AppRadii.panel,
    this.fill = .70,
    this.borderAlpha = .07,
    this.blur = 26,
    this.padding,
    this.shadows,
    this.width,
    this.height,
    this.borderColor,
  });

  final Widget child;
  final double radius;

  /// White fill opacity — the design uses .70, .72, .76 or .80.
  final double fill;
  final double borderAlpha;

  /// Overrides the slate-tinted hairline — the dark scanner uses a white one.
  final Color? borderColor;
  final double blur;
  final EdgeInsetsGeometry? padding;
  final List<BoxShadow>? shadows;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(radius);
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(borderRadius: border, boxShadow: shadows),
      child: ClipRRect(
        borderRadius: border,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: AppColors.whiteA(fill),
              borderRadius: border,
              border: Border.all(
                color: borderColor ?? AppColors.slateA(borderAlpha),
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// A circular frosted button — the notification bell, back chevrons, etc.
class GlassCircle extends StatelessWidget {
  const GlassCircle({
    super.key,
    required this.child,
    this.size = 42,
    this.onTap,
    this.fill = .72,
    this.borderAlpha = .11,
  });

  final Widget child;
  final double size;
  final VoidCallback? onTap;
  final double fill;
  final double borderAlpha;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 24, sigmaY: 24),
          child: Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.whiteA(fill),
              border: Border.all(
                color: AppColors.slateA(borderAlpha),
                width: 1,
              ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
