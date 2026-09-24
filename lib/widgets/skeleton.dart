import 'package:flutter/widgets.dart';

import '../utils/app_colors.dart';

class Skeleton extends StatelessWidget {
  const Skeleton({
    super.key,
    this.width,
    required this.height,
    required this.radius,
    this.color,
    this.gradient,
    this.expand = false,
  });

  /// `rgba(15,23,42,<alpha>)` — the tone the design uses for most bars.
  factory Skeleton.slate({
    double? width,
    required double height,
    required double radius,
    required double alpha,
    bool expand = false,
  }) => Skeleton(
    width: width,
    height: height,
    radius: radius,
    color: AppColors.slateA(alpha),
    expand: expand,
  );

  final double? width;
  final double height;
  final double radius;
  final Color? color;
  final Gradient? gradient;

  final bool expand;

  @override
  Widget build(BuildContext context) {
    final box = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
    return expand ? Expanded(child: box) : box;
  }
}
