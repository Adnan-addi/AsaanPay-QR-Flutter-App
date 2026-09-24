// ignore_for_file: avoid_print

import 'dart:ui';

import 'package:asaanpay_qr/dashboard/qr_screens/qr_screen.dart';
import 'package:asaanpay_qr/dashboard/quick_action.dart';
import 'package:asaanpay_qr/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_screen.dart';
import '../../widgets/bottom_nav.dart';
import '../../widgets/glass.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.showNav = true});

  final bool showNav;

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      scrollable: true,
      topPadding: 8,
      bottomNav: showNav ? const BottomNav(current: NavTab.home) : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const _Header(),
          const SizedBox(height: 24),
          const BalanceCard(),
          const SizedBox(height: 32),
          // QuickActions(onTap: (_) {}),
          QuickActions(
            onTap: (label) {
              if (label == 'Scan QR') {
                Get.to(
                  () => ScanQrScreen(),
                  transition: Transition.rightToLeft,
                );
              }
            },
          ),
          SizedBox(height: 25.h),

          SizedBox(height: 25.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  'Recent activity',
                  style: AppText.section,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'See all',
                style: AppText.label13.copyWith(color: AppColors.inkMuted),
              ),
            ],
          ),
          const SizedBox(height: 14),
          // const _ActivityList(),
          const _ActivityList(),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: AppGradients.diagonal,
          ),
          child: Text(
            'QM',
            style: AppText.body15Semi.copyWith(color: AppColors.white),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Qasim Mobiles',
                style: AppText.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text('Merchant account', style: AppText.caption12),
            ],
          ),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            GlassCircle(
              size: 42,
              onTap: () {},
              child: const AppIcon('bell', size: 20),
            ),
            Positioned(
              top: 7,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.teal,
                  border: Border.all(color: AppColors.white, width: 2),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class BalanceCard extends StatelessWidget {
  const BalanceCard({
    super.key,
    // required this.merchant,
    this.onAddMoney,
    this.onTransfer,
  });

  // final Merchant merchant;
  final VoidCallback? onAddMoney;
  final VoidCallback? onTransfer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 196,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadii.card),
        boxShadow: AppShadows.balanceCard,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.card),
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: AppGradients.card,
            border: Border.all(color: AppColors.whiteA(.22), width: 1),
            borderRadius: BorderRadius.circular(AppRadii.card),
          ),
          child: Stack(
            children: [
              _highlight(right: -70, top: -90, size: 280, opacity: .20),
              _highlight(left: -60, bottom: -80, size: 200, opacity: .12),
              Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AVAILABLE BALANCE',
                                style: AppText.eyebrow.copyWith(
                                  color: AppColors.whiteA(.72),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              // Balances well past the mocked figure still have
                              // to fit on one line.
                              FittedBox(
                                fit: BoxFit.scaleDown,
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Rs. 2000,000",
                                  style: AppText.balance,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.whiteA(.22),
                            borderRadius: BorderRadius.circular(AppRadii.small),
                            border: Border.all(color: AppColors.whiteA(.30)),
                          ),
                          child: Text('ACTIVE', style: AppText.pill),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    Text(
                      // merchant.raastLabel,
                      "Raast ID: ****999",
                      style: AppText.caption.copyWith(
                        color: AppColors.whiteA(.78),
                        fontFamily: 'Inter',
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Flexible(
                          child: _CardAction(
                            icon: 'add_money',
                            label: 'Add Money',
                            onTap: onAddMoney,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: _CardAction(
                            icon: 'transfer',
                            label: 'Transfer',
                            onTap: onTransfer,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _highlight({
    double? left,
    double? right,
    double? top,
    double? bottom,
    required double size,
    required double opacity,
  }) {
    return Positioned(
      left: left,
      right: right,
      top: top,
      bottom: bottom,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [
              AppColors.whiteA(opacity),
              AppColors.whiteA(opacity * .5),
              AppColors.whiteA(0),
            ],
            stops: const [0, .5, 1],
          ),
        ),
      ),
    );
  }
}

class _CardAction extends StatelessWidget {
  const _CardAction({required this.icon, required this.label, this.onTap});

  final String icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.whiteA(.18),
              borderRadius: BorderRadius.circular(AppRadii.pill),
              border: Border.all(color: AppColors.whiteA(.28)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppIcon(icon, size: 16, color: AppColors.white),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    label,
                    style: AppText.label13Semi.copyWith(color: AppColors.white),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ActivityList extends StatelessWidget {
  const _ActivityList();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      radius: AppRadii.tile,
      fill: .72,
      borderAlpha: .08,
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          _ActivityTile(
            title: 'Payment received',
            subtitle: 'QR · 01:34 PM',
            amount: '+ Rs 27,000',
            incoming: true,
          ),
          _ActivityTile(
            title: 'Bank transfer',
            subtitle: 'FMB · 12:30 PM',
            amount: '- Rs 5,000',
            incoming: false,
          ),
          _ActivityTile(
            title: 'Payment received',
            subtitle: 'QR · 11:15 AM',
            amount: '+ Rs 12,500',
            incoming: true,
          ),
          _ActivityTile(
            title: 'Payment sent',
            subtitle: 'Bank · 10:20 AM',
            amount: '- Rs 2,800',
            incoming: false,
          ),
        ],
      ),
    );
  }
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.incoming,
  });

  final String title;
  final String subtitle;
  final String amount;
  final bool incoming;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: AppColors.bgBottom.withValues(alpha: .06)),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(9),
              color: incoming ? AppColors.tealA(.10) : AppColors.blueA(.10),
            ),
            child: Icon(
              incoming ? Icons.call_received_rounded : Icons.call_made_rounded,
              size: 16,
              color: incoming ? AppColors.tealDeep : AppColors.blue,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  // style: AppText.label13Semi,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontFamily: 'Inter',
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: AppText.caption12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            amount,
            style: AppText.label13Semi.copyWith(
              color: incoming ? AppColors.tealDeep : AppColors.scanBottom,
            ),
          ),
        ],
      ),
    );
  }
}
