import 'package:flutter/widgets.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_text.dart';
import 'glass.dart';

/// The horizontal filter row: the selected chip is a gradient pill, the rest
/// are frosted.
class FilterChips extends StatelessWidget {
  const FilterChips({
    super.key,
    required this.labels,
    required this.selected,
    this.onSelect,
  });

  final List<String> labels;
  final int selected;
  final ValueChanged<int>? onSelect;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const ClampingScrollPhysics(),
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++) ...[
            if (i > 0) const SizedBox(width: 9),
            _Chip(
              label: labels[i],
              active: i == selected,
              onTap: () => onSelect?.call(i),
            ),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, required this.active, this.onTap});

  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.symmetric(horizontal: 16, vertical: 9);

    if (active) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            gradient: AppGradients.primary,
            borderRadius: BorderRadius.circular(AppRadii.pill),
            boxShadow: [
              BoxShadow(
                color: AppColors.blueA(.60),
                blurRadius: 18,
                spreadRadius: -6,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Text(
            label,
            style: AppText.label125.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.white,
            ),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: GlassCard(
        radius: AppRadii.pill,
        fill: .72,
        borderAlpha: .09,
        blur: 22,
        padding: padding,
        child: Text(
          label,
          style: AppText.label125.copyWith(color: AppColors.inkSoft),
        ),
      ),
    );
  }
}

/// The uppercase `600 10.5px` label the design uses above grouped content.
class Eyebrow extends StatelessWidget {
  const Eyebrow(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) => Text(text, style: AppText.eyebrow);
}

/// A thin gradient progress bar — used by the seven-step sign-up.
class StepProgress extends StatelessWidget {
  const StepProgress({super.key, required this.value});

  /// 0–1.
  final double value;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(2),
      child: Container(
        height: 3,
        color: AppColors.slateA(.07),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: value.clamp(0, 1),
          child: const DecoratedBox(
            decoration: BoxDecoration(gradient: AppGradients.primary),
          ),
        ),
      ),
    );
  }
}
