import 'package:flutter/widgets.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_text.dart';
import 'app_icon.dart';
import 'glass.dart';

/// A question with a Yes/No pair — the compliance step is built from these.
class YesNoQuestion extends StatelessWidget {
  const YesNoQuestion({
    super.key,
    required this.question,
    required this.value,
    this.onChanged,
  });

  final String question;
  final bool value;
  final ValueChanged<bool>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(question, style: AppText.label14),
        const SizedBox(height: 11),
        Row(
          children: [
            Expanded(
              child: _Option(
                label: 'Yes',
                active: value,
                onTap: () => onChanged?.call(true),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: _Option(
                label: 'No',
                active: !value,
                onTap: () => onChanged?.call(false),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({required this.label, required this.active, this.onTap});

  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const padding = EdgeInsets.all(11);

    if (active) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: padding,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: AppGradients.primary,
            borderRadius: BorderRadius.circular(AppRadii.pill),
            boxShadow: [
              BoxShadow(
                color: AppColors.blueA(.55),
                blurRadius: 16,
                spreadRadius: -6,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Text(
            label,
            style: AppText.label13Semi.copyWith(color: AppColors.white),
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
        child: Center(
          child: Text(
            label,
            style: AppText.label13.copyWith(color: AppColors.inkSoft),
          ),
        ),
      ),
    );
  }
}

/// Paints the dashed outline the design uses on upload targets.
class _DashedRRect extends CustomPainter {
  const _DashedRRect({required this.radius, required this.color});

  final double radius;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1
      ..color = color;

    final path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(radius)),
      );

    const dash = 6.0;
    const gap = 5.0;
    for (final metric in path.computeMetrics()) {
      var d = 0.0;
      while (d < metric.length) {
        canvas.drawPath(
          metric.extractPath(d, (d + dash).clamp(0, metric.length)),
          paint,
        );
        d += dash + gap;
      }
    }
  }

  @override
  bool shouldRepaint(_DashedRRect old) =>
      old.radius != radius || old.color != color;
}

/// The dashed "Upload your shop picture" target.
class UploadCard extends StatelessWidget {
  const UploadCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.icon = 'camera',
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: CustomPaint(
        foregroundPainter: _DashedRRect(
          radius: AppRadii.panel,
          color: AppColors.slateA(.18),
        ),
        child: GlassCard(
          radius: AppRadii.panel,
          borderAlpha: 0,
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              AppIcon(icon, size: 24, color: AppColors.inkSoft),
              const SizedBox(height: 8),
              Text(title, style: AppText.label14Semi),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: AppText.caption18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
