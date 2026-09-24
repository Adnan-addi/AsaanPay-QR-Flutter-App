import 'package:flutter/widgets.dart';

import '../../../utils/app_colors.dart';
import '../../../utils/app_styles.dart';
import '../../../utils/app_text.dart';
import '../../../widgets/app_icon.dart';
import '../../../widgets/glass.dart';

/// The row of four 60px frosted tiles under the balance card.
class QuickActions extends StatelessWidget {
  const QuickActions({super.key, this.onTap});

  final ValueChanged<String>? onTap;

  static const _items = <({String icon, String label})>[
    (icon: 'scan_qr', label: 'Scan QR'),
    (icon: 'qr', label: 'My QR'),
    (icon: 'receive', label: 'Receive'),
    (icon: 'download', label: 'Top-up'),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        for (final item in _items)
          GestureDetector(
            onTap: () => onTap?.call(item.label),
            behavior: HitTestBehavior.opaque,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GlassCard(
                  width: 60,
                  height: 60,
                  radius: AppRadii.tile,
                  fill: .76,
                  borderAlpha: .09,
                  blur: 22,
                  child: Center(child: AppIcon(item.icon, size: 23)),
                ),
                const SizedBox(height: 10),
                Text(
                  item.label,
                  style: AppText.caption.copyWith(color: AppColors.inkSoft),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
