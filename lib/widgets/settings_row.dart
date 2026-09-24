import 'package:flutter/widgets.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_text.dart';
import 'app_icon.dart';
import 'glass.dart';

/// One line in a settings-style list: tinted glyph, title, optional subtitle,
/// and a trailing chevron unless something else is supplied.
class SettingsRow extends StatelessWidget {
  const SettingsRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.tint = AppColors.blue,
    this.glyphColor = AppColors.blueDeep,
    this.titleColor,
    this.trailing,
    this.showChevron = true,
  });

  final String icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Color tint;
  final Color glyphColor;
  final Color? titleColor;
  final Widget? trailing;
  final bool showChevron;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 15),
        child: Row(
          children: [
            Container(
              width: 38,
              height: 38,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tint.withValues(alpha: .10),
                borderRadius: BorderRadius.circular(AppRadii.icon),
                border: Border.all(color: tint.withValues(alpha: .20)),
              ),
              child: AppIcon(icon, size: 19, color: glyphColor),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppText.body145.copyWith(
                      letterSpacing: -0.1,
                      color: titleColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: AppText.caption,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null)
              trailing!
            else if (showChevron)
              const AppIcon(
                'chevron_right',
                size: 18,
                color: AppColors.inkFaint,
              ),
          ],
        ),
      ),
    );
  }
}

/// A frosted panel wrapping a run of rows, hairline-separated.
class SettingsGroup extends StatelessWidget {
  const SettingsGroup({super.key, required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: AppRadii.panel,
      child: Column(
        children: [
          for (var i = 0; i < children.length; i++) ...[
            if (i > 0)
              Container(
                height: 1,
                margin: const EdgeInsets.symmetric(horizontal: 18),
                color: AppColors.slateA(.055),
              ),
            children[i],
          ],
        ],
      ),
    );
  }
}

/// The small teal `✓ VERIFIED MERCHANT` pill.
class StatusPill extends StatelessWidget {
  const StatusPill({
    super.key,
    required this.label,
    this.icon = 'check',
    this.color = AppColors.tealDeep,
    this.tint = AppColors.teal,
  });

  final String label;
  final String icon;
  final Color color;
  final Color tint;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: tint.withValues(alpha: .13),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: tint.withValues(alpha: .28)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(icon, size: 12, color: color),
          const SizedBox(width: 5),
          Text(
            label,
            style: AppText.eyebrow.copyWith(
              fontSize: 10.5,
              letterSpacing: 0.3,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// One of the paired `THIS MONTH / PAYMENTS` figures.
class StatTile extends StatelessWidget {
  const StatTile({super.key, required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: AppRadii.tile,
      fill: .72,
      borderAlpha: .08,
      blur: 22,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppText.eyebrow.copyWith(letterSpacing: 1.2)),
          const SizedBox(height: 5),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              value,
              maxLines: 1,
              style: AppText.title.copyWith(
                fontSize: 19,
                letterSpacing: -0.6,
                height: 1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
