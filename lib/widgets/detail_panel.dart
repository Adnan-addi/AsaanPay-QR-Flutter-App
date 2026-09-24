import 'package:flutter/widgets.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_text.dart';
import 'app_icon.dart';
import 'glass.dart';

/// One `label — value` line inside a [DetailPanel].
@immutable
class DetailRow {
  const DetailRow(this.label, this.value, {this.emphasis});

  final String label;
  final String value;

  /// Overrides the value colour — the design tints `Completed` teal.
  final Color? emphasis;
}

/// The frosted panel of label/value rows used by receipts and detail screens.
class DetailPanel extends StatelessWidget {
  const DetailPanel({
    super.key,
    required this.rows,
    this.radius = AppRadii.panel,
  });

  final List<DetailRow> rows;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: radius,
      fill: .72,
      borderAlpha: .08,
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0)
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 20),
                color: AppColors.slateA(.055),
              ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Row(
                children: [
                  Text(rows[i].label, style: AppText.body13),
                  const Spacer(),
                  Flexible(
                    child: Text(
                      rows[i].value,
                      textAlign: TextAlign.right,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppText.label135.copyWith(
                        letterSpacing: -0.1,
                        color: rows[i].emphasis ?? AppColors.ink,
                        fontWeight: rows[i].emphasis != null
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The 88px gradient tick with its two concentric rings — the success moment.
class SuccessBadge extends StatelessWidget {
  const SuccessBadge({super.key, this.icon = 'check_circle', this.size = 88});

  final String icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + 44,
      height: size + 44,
      child: Stack(
        alignment: Alignment.center,
        children: [
          _ring(size + 44, .16),
          _ring(size + 20, .30),
          Container(
            width: size,
            height: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppGradients.diagonal,
              boxShadow: [
                BoxShadow(
                  color: AppColors.tealA(.60),
                  blurRadius: 40,
                  spreadRadius: -10,
                  offset: const Offset(0, 16),
                ),
              ],
            ),
            child: AppIcon(icon, size: size * 0.48, color: AppColors.white),
          ),
        ],
      ),
    );
  }

  Widget _ring(double d, double alpha) => Container(
    width: d,
    height: d,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: AppColors.tealA(alpha)),
    ),
  );
}

/// A pair of equal frosted buttons — Share/Save, Gallery/My QR.
class DualAction extends StatelessWidget {
  const DualAction({
    super.key,
    required this.left,
    required this.right,
    this.onLeft,
    this.onRight,
    this.dark = false,
  });

  final ({String icon, String label}) left;
  final ({String icon, String label}) right;
  final VoidCallback? onLeft;
  final VoidCallback? onRight;

  /// The scanner variant sits on the dark ground.
  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _Button(item: left, onTap: onLeft, dark: dark),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _Button(item: right, onTap: onRight, dark: dark),
        ),
      ],
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({required this.item, this.onTap, required this.dark});

  final ({String icon, String label}) item;
  final VoidCallback? onTap;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final fg = dark ? AppColors.white : AppColors.ink;
    final glyph = dark ? AppColors.white : AppColors.blueDeep;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: GlassCard(
        radius: AppRadii.field,
        fill: dark ? .10 : .72,
        borderAlpha: .10,
        borderColor: dark ? AppColors.whiteA(.18) : null,
        blur: 24,
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AppIcon(item.icon, size: 19, color: glyph),
            const SizedBox(width: 9),
            Flexible(
              child: Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppText.label14Semi.copyWith(
                  fontFamily: 'Inter',
                  color: fg,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
