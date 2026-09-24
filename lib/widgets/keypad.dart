import 'package:flutter/widgets.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_text.dart';
import 'app_icon.dart';
import 'glass.dart';

/// The row of filled/empty dots showing MPIN progress.
class PinDots extends StatelessWidget {
  const PinDots({super.key, required this.filled, this.length = 4});

  final int filled;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < length; i++) ...[
          if (i > 0) const SizedBox(width: 16),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: i < filled ? AppGradients.diagonal : null,
              color: i < filled ? null : AppColors.slateA(.10),
            ),
          ),
        ],
      ],
    );
  }
}

/// The 3x4 numeric keypad: nine digits, a biometric key, zero and backspace.
class NumericKeypad extends StatelessWidget {
  const NumericKeypad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
    this.onBiometric,
    this.spacing = 11,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;
  final VoidCallback? onBiometric;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var row = 0; row < 4; row++) ...[
          if (row > 0) SizedBox(height: spacing),
          Row(
            children: [
              for (var col = 0; col < 3; col++) ...[
                if (col > 0) SizedBox(width: spacing),
                Expanded(child: _key(row, col)),
              ],
            ],
          ),
        ],
      ],
    );
  }

  Widget _key(int row, int col) {
    if (row < 3) {
      final digit = '${row * 3 + col + 1}';
      return _DigitKey(label: digit, onTap: () => onDigit(digit));
    }
    return switch (col) {
      0 => _GlyphKey(
        icon: 'scan',
        color: AppColors.tealDeep,
        onTap: onBiometric,
      ),
      1 => _DigitKey(label: '0', onTap: () => onDigit('0')),
      _ => _GlyphKey(
        icon: 'backspace',
        color: AppColors.inkSoft,
        onTap: onBackspace,
      ),
    };
  }
}

class _DigitKey extends StatelessWidget {
  const _DigitKey({required this.label, this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: GlassCard(
        height: 56,
        radius: AppRadii.field,
        fill: .72,
        borderAlpha: .08,
        blur: 22,
        child: Center(
          child: Text(
            label,
            style: AppText.amount.copyWith(letterSpacing: -0.4),
          ),
        ),
      ),
    );
  }
}

/// The two unfilled keys — biometric and backspace sit on the background.
class _GlyphKey extends StatelessWidget {
  const _GlyphKey({required this.icon, required this.color, this.onTap});

  final String icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        height: 56,
        child: Center(child: AppIcon(icon, size: 22, color: color)),
      ),
    );
  }
}
