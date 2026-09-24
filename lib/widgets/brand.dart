import 'package:flutter/widgets.dart';

import '../utils/app_styles.dart';

/// The official AsaanPay artwork, bundled from the brand files.
///
/// These are the supplied logos used as-is — nothing is redrawn. The Q counter
/// in each file is filled white so the artwork composites correctly over the
/// app's light gradient instead of showing it through.
abstract final class BrandAsset {
  /// The app tile on its own, with transparent corners.
  static const icon = 'assets/brand/asaanpay_icon.png';

  /// The same tile, opaque edge to edge — for launcher-style contexts.
  static const iconSolid = 'assets/brand/asaanpay_icon_solid.png';

  /// Tile + wordmark, side by side.
  static const lockup = 'assets/brand/asaanpay_lockup.png';

  /// Tile above the wordmark.
  static const stacked = 'assets/brand/asaanpay_stacked.png';

  /// The white Q mark alone.
  static const mark = 'assets/brand/asaanpay_mark.png';
}

/// The app tile. [size] is the width and height of the rounded square.
class BrandIcon extends StatelessWidget {
  const BrandIcon({super.key, this.size = 56, this.shadow = true});

  final double size;
  final bool shadow;

  @override
  Widget build(BuildContext context) {
    final image = Image.asset(
      BrandAsset.icon,
      width: size,
      height: size,
      filterQuality: FilterQuality.medium,
    );

    if (!shadow) return image;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size * 0.24),
        boxShadow: AppShadows.chip,
      ),
      child: image,
    );
  }
}

/// Tile + wordmark on one line. [height] sizes the tile; the wordmark follows.
class BrandLockup extends StatelessWidget {
  const BrandLockup({super.key, this.height = 56});

  final double height;

  /// The artwork's aspect ratio, so the widget reserves the right width.
  static const _aspect = 929 / 234;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      BrandAsset.lockup,
      height: height,
      width: height * _aspect,
      fit: BoxFit.contain,
      alignment: Alignment.centerLeft,
      filterQuality: FilterQuality.medium,
    );
  }
}

/// Tile above the wordmark — for splash-style, centred placements.
class BrandStacked extends StatelessWidget {
  const BrandStacked({super.key, this.width = 200});

  final double width;

  static const _aspect = 940 / 555;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      BrandAsset.stacked,
      width: width,
      height: width / _aspect,
      fit: BoxFit.contain,
      filterQuality: FilterQuality.medium,
    );
  }
}
