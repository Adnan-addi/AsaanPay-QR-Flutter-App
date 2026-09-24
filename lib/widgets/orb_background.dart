import 'package:flutter/widgets.dart';

import '../utils/app_colors.dart';

/// One of the soft colour washes the design floats behind every screen.
///
/// In the source these are 260–440px circles with `filter: blur(100px)`. A real
/// Gaussian blur that wide is costly to composite every frame on device, so we
/// draw the same wash as a [RadialGradient] — visually equivalent at these
/// radii, and free to paint.
@immutable
class Orb {
  const Orb({
    required this.left,
    required this.top,
    required this.size,
    required this.color,
    required this.opacity,
  });

  /// Offsets are in the design's 393x852 coordinate space and may be negative.
  final double left;
  final double top;
  final double size;
  final Color color;
  final double opacity;

  static const homeDefaults = <Orb>[
    Orb(left: -160, top: -170, size: 440, color: AppColors.blue, opacity: .30),
    Orb(left: 220, top: 80, size: 340, color: AppColors.teal, opacity: .26),
    Orb(
      left: -80,
      top: 460,
      size: 420,
      color: AppColors.blueRoyal,
      opacity: .20,
    ),
    Orb(left: 170, top: 650, size: 260, color: AppColors.teal, opacity: .15),
  ];
}

/// The screen background: the vertical white → #E8EFF9 gradient plus the orbs.
class OrbBackground extends StatelessWidget {
  const OrbBackground({super.key, this.orbs = Orb.homeDefaults, this.child});

  final List<Orb> orbs;
  final Widget? child;

  /// The design's frame height; orb offsets are relative to it.
  static const designHeight = 852.0;
  static const designWidth = 393.0;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Scale the orb field to the real screen so the wash keeps its
        // proportions on taller or shorter devices than the 393x852 mock.
        final sx = constraints.maxWidth / designWidth;
        final sy = constraints.maxHeight / designHeight;

        return DecoratedBox(
          decoration: const BoxDecoration(gradient: AppGradients.screen),
          child: Stack(
            fit: StackFit.expand,
            children: [
              for (final orb in orbs)
                Positioned(
                  left: orb.left * sx,
                  top: orb.top * sy,
                  width: orb.size * sx,
                  height: orb.size * sx,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          orb.color.withValues(alpha: orb.opacity),
                          orb.color.withValues(alpha: orb.opacity * .55),
                          orb.color.withValues(alpha: 0),
                        ],
                        stops: const [0.0, 0.45, 1.0],
                      ),
                    ),
                  ),
                ),
              // The 1px hairline the design draws across the very top.
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                height: 1,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.slateA(0),
                        AppColors.slateA(.14),
                        AppColors.slateA(0),
                      ],
                    ),
                  ),
                ),
              ),
              ?child,
            ],
          ),
        );
      },
    );
  }
}
