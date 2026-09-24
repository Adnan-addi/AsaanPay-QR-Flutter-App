import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/app_colors.dart';

/// Renders one of the SVG glyphs lifted verbatim from the design file.
///
/// The source glyphs are stroked with `currentColor`, so [color] maps onto
/// them the same way it did in the original markup.
class AppIcon extends StatelessWidget {
  const AppIcon(
    this.name, {
    super.key,
    this.size = 20,
    this.color = AppColors.ink,
  });

  final String name;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$name.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
    );
  }
}
