import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../utils/app_text.dart';
import '../../utils/screen_orbs.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_screen.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/detail_panel.dart';
import '../../widgets/glass.dart';

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key, this.showNav = true});

  final bool showNav;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      orbs: ScreenOrbs.of('32'),
      scrollable: true,
      topPadding: 10,
      bottomNav: showNav ? const BottomNav(current: NavTab.cards) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Cards', style: AppText.title),
              const GlassCard(
                width: 42,
                height: 42,
                radius: AppRadii.pill,
                fill: .72,
                borderAlpha: .10,
                blur: 24,
                child: Center(child: AppIcon('plus', size: 20)),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const _CardFace(
            name: 'Habib Bank Limited',
            badge: 'VISA',
            number: '•••• 6171',
            holder: 'ZAIN ASIF',
            primary: true,
          ),
          const SizedBox(height: 14),
          const _CardFace(
            name: 'Meezan Bank',
            badge: 'DEBIT',
            number: '•••• 4582',
            holder: 'ZAIN ASIF',
            primary: false,
          ),
          const SizedBox(height: 26),
          Text('RAAST ACCOUNT', style: AppText.caption12),
          const SizedBox(height: 12),
          const DetailPanel(
            rows: [
              DetailRow('Raast ID', '0314 6171875'),
              DetailRow('Bank', 'Habib Bank Limited'),
              DetailRow('Status', 'Active', emphasis: AppColors.tealDeep),
            ],
          ),
          const SizedBox(height: 20),
          GlassCard(
            radius: AppRadii.tile,
            fill: .72,
            borderAlpha: .11,
            blur: 24,
            padding: const EdgeInsets.all(18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppIcon(
                  'plus_circle',
                  size: 19,
                  color: AppColors.tealDeep,
                ),
                const SizedBox(width: 10),
                Text(
                  'Add a bank account or card',
                  style: AppText.body15Semi.copyWith(fontSize: 15),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardFace extends StatelessWidget {
  const _CardFace({
    required this.name,
    required this.badge,
    required this.number,
    required this.holder,
    required this.primary,
  });

  final String name;
  final String badge;
  final String number;
  final String holder;
  final bool primary;

  @override
  Widget build(BuildContext context) {
    final title = AppText.body15Semi.copyWith(
      letterSpacing: -0.2,
      color: primary ? AppColors.white : AppColors.ink,
    );

    final content = Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(name, style: title)),
              const SizedBox(width: 10),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: primary
                      ? AppColors.whiteA(.22)
                      : AppColors.slateA(.06),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: primary
                        ? AppColors.whiteA(.30)
                        : AppColors.slateA(.10),
                  ),
                ),
                child: Text(
                  badge,
                  style: AppText.pill.copyWith(
                    color: primary ? AppColors.white : AppColors.inkMuted,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 26),
          Text(
            number,
            style: AppText.amount.copyWith(
              fontSize: 18,
              letterSpacing: 1.5,
              color: primary ? AppColors.white : AppColors.ink,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            holder,
            style: AppText.caption12.copyWith(
              color: primary ? AppColors.whiteA(.80) : AppColors.inkMuted,
            ),
          ),
        ],
      ),
    );

    if (!primary) {
      return GlassCard(
        radius: AppRadii.panel,
        fill: .72,
        borderAlpha: .08,
        child: content,
      );
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.panel),
        boxShadow: AppShadows.balanceCard,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.panel),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppGradients.card,
            borderRadius: BorderRadius.circular(AppRadii.panel),
            border: Border.all(color: AppColors.whiteA(.22)),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -60,
                top: -80,
                child: Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [AppColors.whiteA(.20), AppColors.whiteA(0)],
                    ),
                  ),
                ),
              ),
              content,
            ],
          ),
        ),
      ),
    );
  }
}
