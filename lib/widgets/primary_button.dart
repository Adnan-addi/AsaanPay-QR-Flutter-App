import 'package:flutter/widgets.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_text.dart';

/// The full-width gradient CTA: 20px padding, 20px radius, `600 17px` label.
class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.label,
    this.onTap,
    this.enabled = true,
    this.icon,
    this.height,
  });

  final String label;
  final VoidCallback? onTap;
  final bool enabled;
  final Widget? icon;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1 : .45,
      child: GestureDetector(
        onTap: enabled ? onTap : null,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: height,
          padding: height == null ? const EdgeInsets.all(20) : null,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: AppGradients.primary,
            borderRadius: BorderRadius.circular(AppRadii.tile),
            boxShadow: enabled ? AppShadows.cta : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[icon!, const SizedBox(width: 10)],
              Text(
                label,
                style: AppText.section.copyWith(
                  color: AppColors.white,
                  letterSpacing: -0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Secondary, low-emphasis action rendered as plain tinted text.
class TextAction extends StatelessWidget {
  const TextAction({super.key, required this.label, this.onTap, this.color});

  final String label;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 4),
        child: Text(
          label,
          style: AppText.label14.copyWith(color: color ?? AppColors.inkMuted),
        ),
      ),
    );
  }
}
