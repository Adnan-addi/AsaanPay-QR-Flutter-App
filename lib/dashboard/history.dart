import 'package:asaanpay_qr/dashboard/transaction_detailed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../utils/app_text.dart';
import '../../utils/screen_orbs.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_screen.dart';
import '../../widgets/chips.dart';
import '../../widgets/glass.dart';
import '../../widgets/top_bar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key, this.showBack = true});

  final bool showBack;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      orbs: ScreenOrbs.of('07'),
      scrollable: true,
      topPadding: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TopBar(title: 'Transactions', showBack: showBack),
          const SizedBox(height: 28),
          GlassCard(
            radius: 20,
            fill: .72,
            borderAlpha: .11,
            blur: 24,
            padding: const EdgeInsets.all(19),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppIcon('download', size: 20, color: AppColors.tealDeep),
                const SizedBox(width: 10),
                Text(
                  'Download e-statement',
                  style: AppText.body15Semi.copyWith(fontSize: 16),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          FilterChips(
            labels: const ['All', 'Received', 'Sent', 'Raast'],
            selected: 0,
            onSelect: (_) {},
          ),
          const SizedBox(height: 32),
          _HistoryGroup(
            title: 'TODAY',
            items: [
              _HistoryItem(
                title: 'Money sent via Raast',
                subtitle: '01:34 PM',
                amount: '- Rs 27,000',
                icon: Icons.call_made_rounded,
                iconColor: AppColors.blueDeep,
                onTap: () {
                  Get.to(
                    () => const TransactionDetailScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
              ),
              _HistoryItem(
                title: 'Bank transfer — Fee',
                subtitle: '12:30 PM',
                amount: '- Rs 5,000',
                icon: Icons.credit_card_rounded,
                iconColor: AppColors.blueDeep,
                onTap: () {
                  Get.to(
                    () => const TransactionDetailScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 28),

          _HistoryGroup(
            title: '23 JANUARY',
            items: [
              _HistoryItem(
                title: 'Money sent via Raast',
                subtitle: '07:33 AM',
                amount: '- Rs 50,000',
                icon: Icons.qr_code_rounded,
                iconColor: AppColors.blueDeep,
                onTap: () {
                  Get.to(
                    () => const TransactionDetailScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
              ),
              _HistoryItem(
                title: 'Fund transfer from...',
                subtitle: '12:30 PM',
                amount: '+ Rs 22,000',
                icon: Icons.call_received_rounded,
                iconColor: AppColors.tealDeep,
                onTap: () {
                  Get.to(
                    () => const TransactionDetailScreen(),
                    transition: Transition.rightToLeft,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HistoryGroup extends StatelessWidget {
  const _HistoryGroup({required this.title, required this.items});

  final String title;
  final List<_HistoryItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(title, style: AppText.caption12),
        const SizedBox(height: 12),
        for (var i = 0; i < items.length; i++) ...[
          items[i],
          if (i < items.length - 1) const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _HistoryItem extends StatelessWidget {
  const _HistoryItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.icon,
    required this.iconColor,
    this.onTap,
  });

  final String title;
  final String subtitle;
  final String amount;
  final IconData icon;
  final Color iconColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: GlassCard(
        radius: AppRadii.tile,
        fill: .72,
        borderAlpha: .08,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            GlassCard(
              width: 45,
              height: 50,
              radius: AppRadii.pill,
              fill: .72,
              borderAlpha: .08,
              child: Center(
                child: Icon(icon, size: 18.sp, color: iconColor),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    // style: AppText.body13.copyWith(
                    //   fontSize: 14.sp,
                    //   fontFamily: 'Inter',
                    //   fontWeight: FontWeight.w500,
                    // ),
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.ink,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    // style: AppText.caption12.copyWith(
                    //   fontSize: 11.sp,
                    //   fontFamily: 'Inter',
                    // ),
                    // ),
                    style: TextStyle(
                      fontSize: 11.sp,
                      color: AppColors.inkMuted,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(
              amount,
              // style: AppText.body13.copyWith(fontSize: 13.sp),
              // ),
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.ink,
                fontFamily: 'Inter',
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
