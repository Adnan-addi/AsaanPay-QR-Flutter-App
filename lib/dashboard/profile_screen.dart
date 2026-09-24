import 'package:asaanpay_qr/widgets/chips.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../utils/app_text.dart';
import '../../utils/screen_orbs.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_screen.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/glass.dart';
import '../../widgets/settings_row.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, this.showNav = true});

  final bool showNav;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      orbs: ScreenOrbs.of('19'),
      scrollable: true,
      topPadding: 10,
      bottomNav: showNav ? const BottomNav(current: NavTab.profile) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Profile', style: AppText.title),
              const GlassCard(
                width: 42,
                height: 42,
                radius: AppRadii.pill,
                fill: .72,
                borderAlpha: .10,
                blur: 24,
                child: Center(child: AppIcon('settings', size: 19)),
              ),
            ],
          ),
          const SizedBox(height: 22),
          const _IdentityCard(),
          const SizedBox(height: 20),
          const Row(
            children: [
              Expanded(
                child: StatTile(label: 'THIS MONTH', value: 'Rs 3.4L'),
              ),
              SizedBox(width: 11),
              Expanded(
                child: StatTile(label: 'PAYMENTS', value: '248'),
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Eyebrow('ACCOUNT'),
          const SizedBox(height: 12),
          SettingsGroup(
            children: [
              SettingsRow(
                icon: 'id_card',
                title: 'Business details',
                subtitle: 'Category, address, documents',
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Eyebrow('SUPPORT'),
          const SizedBox(height: 12),
          SettingsGroup(
            children: [
              SettingsRow(
                icon: 'help_circle',
                title: 'Help centre',
                onTap: () {},
              ),
              SettingsRow(
                icon: 'logout',
                title: 'Log out',
                glyphColor: AppColors.tealDeep,
                showChevron: false,
                onTap: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _IdentityCard extends StatelessWidget {
  const _IdentityCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: AppRadii.panel,
      fill: .74,
      borderAlpha: .08,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 62,
            height: 62,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppGradients.diagonal,
              boxShadow: [
                BoxShadow(
                  color: AppColors.blueA(.70),
                  blurRadius: 26,
                  spreadRadius: -10,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Text(
              'ZA',
              style: AppText.amount.copyWith(
                fontSize: 21,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.4,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zain Asif',
                  style: AppText.name.copyWith(
                    fontSize: 18,
                    letterSpacing: -0.4,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 5),
                Text('0314 6171875 · Multan', style: AppText.caption12),
                const SizedBox(height: 7),
                const StatusPill(label: 'VERIFIED MERCHANT'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
