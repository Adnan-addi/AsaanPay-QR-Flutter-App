import 'package:flutter/widgets.dart';

import '../utils/app_colors.dart';
import '../utils/app_styles.dart';
import '../utils/app_text.dart';
import 'app_icon.dart';
import 'glass.dart';

enum NavTab { home, history, cards, profile }

/// The floating tab bar: a 70px frosted pill inset 28px from each edge, with a
/// 54px gradient scan button lifted 26px above it.
class BottomNav extends StatelessWidget {
  const BottomNav({
    super.key,
    required this.current,
    this.onSelect,
    this.onScan,
  });

  final NavTab current;
  final ValueChanged<NavTab>? onSelect;
  final VoidCallback? onScan;

  static const barHeight = 70.0;

  /// The centre scan button, lifted so it straddles the bar.
  static const fabSize = 62.0;
  static const _fabLift = 30.0;

  /// Vertical room the bar needs, including the FAB overhang.
  static double reservedSpace(BuildContext context) =>
      barHeight + _fabLift + MediaQuery.paddingOf(context).bottom + 12;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: barHeight + _fabLift,
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.bottomCenter,
        children: [
          GlassCard(
            height: barHeight,
            radius: AppRadii.panel,
            fill: .80,
            borderAlpha: .10,
            blur: 30,
            shadows: AppShadows.bottomBar,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _Item(NavTab.home, 'nav_home', 'Home', current, onSelect),
                  _Item(
                    NavTab.history,
                    'nav_history',
                    'History',
                    current,
                    onSelect,
                  ),
                  const SizedBox(width: fabSize),
                  _Item(NavTab.cards, 'nav_cards', 'Cards', current, onSelect),
                  _Item(
                    NavTab.profile,
                    'nav_profile',
                    'Profile',
                    current,
                    onSelect,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: barHeight - fabSize + _fabLift,
            child: GestureDetector(
              onTap: onScan,
              behavior: HitTestBehavior.opaque,
              child: Container(
                width: fabSize,
                height: fabSize,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.diagonal,
                  boxShadow: AppShadows.fab,
                ),
                child: const AppIcon(
                  'nav_scan',
                  size: 30,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Item extends StatelessWidget {
  const _Item(this.tab, this.icon, this.label, this.current, this.onSelect);

  final NavTab tab;
  final String icon;
  final String label;
  final NavTab current;
  final ValueChanged<NavTab>? onSelect;

  @override
  Widget build(BuildContext context) {
    final active = tab == current;
    final color = active ? AppColors.ink : AppColors.inkSoft;
    return GestureDetector(
      onTap: () => onSelect?.call(tab),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppIcon(icon, size: 25, color: color),
          const SizedBox(height: 5),
          Text(
            label,
            style: AppText.navLabel.copyWith(
              fontSize: 10.5,
              color: color,
              fontWeight: active ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
