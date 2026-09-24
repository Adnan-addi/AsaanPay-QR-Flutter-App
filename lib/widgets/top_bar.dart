import 'package:flutter/material.dart';

import '../utils/app_styles.dart';
import '../utils/app_text.dart';
import 'app_icon.dart';
import 'glass.dart';

/// The header most inner screens share: a 42px frosted back button and a
/// `700 24px/32px` title, optionally with a trailing action.
class TopBar extends StatelessWidget {
  const TopBar({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
    this.showBack = true,
  });

  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;
  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBack) ...[
          GestureDetector(
            onTap: onBack ?? () => Navigator.maybePop(context),
            behavior: HitTestBehavior.opaque,
            child: GlassCard(
              width: 42,
              height: 42,
              radius: AppRadii.pill,
              fill: .72,
              borderAlpha: .10,
              blur: 24,
              child: const Center(child: AppIcon('arrow_left', size: 20)),
            ),
          ),
          const SizedBox(width: 16),
        ],
        Expanded(
          child: Text(
            title,
            style: AppText.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (trailing != null) ...[const SizedBox(width: 12), trailing!],
      ],
    );
  }
}
