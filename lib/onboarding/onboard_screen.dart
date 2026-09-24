import 'package:asaanpay_qr/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../utils/app_text.dart';
import '../../utils/screen_orbs.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_screen.dart';
import '../../widgets/glass.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/skeleton.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController pageController = PageController();

  int currentPage = 0;

  static const pages =
      <({String orbId, Widget art, String title, String body})>[
        (
          orbId: '01',
          art: ArtInstantQr(),
          title: 'Instant QR payments, made effortless.',
          body:
              'A fully digital merchant onboarding experience. Accept payments '
              'the moment you sign up — integrated with Raast.',
        ),
        (
          orbId: '02',
          art: ArtCustomQr(),
          title: 'Every QR, exactly your amount.',
          body:
              'Generate secure QR codes with set amounts and expiry windows. '
              'Share them anywhere.',
        ),
        (
          orbId: '03',
          art: ArtHistory(),
          title: 'Every rupee, accounted for.',
          body:
              'Track daily QR settlements in real time. Better records, better '
              'cash flow.',
        ),
      ];

  void next() async {
    if (currentPage < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('onboarding_seen', true);
      Get.offAll(() => const LoginScreen(), transition: Transition.rightToLeft);
    }
  }

  void skip() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_seen', true);
    Get.offAll(() => const LoginScreen(), transition: Transition.rightToLeft);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final page = pages[currentPage];

    return AppScreen(
      orbs: ScreenOrbs.of(page.orbId),
      horizontalPadding: 0,
      topPadding: 0,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: pageController,
              itemCount: pages.length,
              onPageChanged: (index) {
                setState(() {
                  currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return _Page(page: pages[index]);
              },
            ),
          ),
          _Dots(count: pages.length, active: currentPage),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Column(
              children: [
                PrimaryButton(
                  label: currentPage == pages.length - 1
                      ? 'Get Started'
                      : 'Next',
                  onTap: next,
                ),
                const SizedBox(height: 20),
                TextAction(label: 'Skip', onTap: skip),
              ],
            ),
          ),
          SizedBox(height: 46 + MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}

class _Page extends StatelessWidget {
  const _Page({required this.page});

  final ({String orbId, Widget art, String title, String body}) page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.bottomCenter,
              child: page.art,
            ),
          ),
          const SizedBox(height: 52),
          Text(page.title, textAlign: TextAlign.center, style: AppText.hero),
          const SizedBox(height: 16),
          Text(page.body, textAlign: TextAlign.center, style: AppText.body),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  const _Dots({required this.count, required this.active});

  final int count;
  final int active;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var i = 0; i < count; i++) ...[
          if (i > 0) const SizedBox(width: 8),
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            width: i == active ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: i == active ? AppColors.blue : AppColors.divider,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ],
      ],
    );
  }
}

class OnboardingArt extends StatelessWidget {
  const OnboardingArt({super.key, required this.child, this.gap = 12});

  final Widget child;
  final double gap;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      width: 196,
      height: 340,
      radius: AppRadii.sheet,
      fill: .72,
      borderAlpha: .10,
      blur: 20,
      padding: const EdgeInsets.all(14),
      shadows: [
        BoxShadow(
          color: AppColors.blueA(.32),
          blurRadius: 64,
          spreadRadius: -22,
          offset: const Offset(0, 26),
        ),
      ],
      child: child,
    );
  }
}

class ArtInstantQr extends StatelessWidget {
  const ArtInstantQr({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingArt(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: 20,
                height: 20,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.primary,
                ),
              ),
              const SizedBox(width: 7),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Skeleton.slate(width: 56, height: 5, radius: 3, alpha: .40),
                  const SizedBox(height: 4),
                  Skeleton.slate(width: 36, height: 4, radius: 2, alpha: .16),
                ],
              ),
            ],
          ),
          const SizedBox(height: 11),
          _MiniBalanceTile(),
          const SizedBox(height: 11),
          Row(
            children: [
              for (var i = 0; i < 4; i++) ...[
                if (i > 0) const SizedBox(width: 9),
                Expanded(
                  child: Container(
                    height: 34,
                    decoration: BoxDecoration(
                      color: AppColors.slateA(.055),
                      borderRadius: BorderRadius.circular(AppRadii.xs),
                      border: Border.all(color: AppColors.slateA(.09)),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 11),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(11),
              decoration: BoxDecoration(
                color: AppColors.whiteA(.70),
                borderRadius: BorderRadius.circular(AppRadii.chip),
                border: Border.all(color: AppColors.slateA(.07)),
              ),
              child: Column(
                children: [
                  for (var i = 0; i < 3; i++) ...[
                    if (i > 0) const SizedBox(height: 12),
                    _MiniRow(incoming: i != 1),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniBalanceTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadii.chip),
      child: Container(
        height: 88,
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(gradient: AppGradients.card),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              right: -30,
              top: -40,
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [AppColors.whiteA(.20), AppColors.whiteA(0)],
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Skeleton(
                  width: 44,
                  height: 4,
                  radius: 2,
                  color: AppColors.whiteA(.6),
                ),
                Skeleton(
                  width: 88,
                  height: 13,
                  radius: 4,
                  color: AppColors.whiteA(.92),
                ),
                Skeleton(
                  width: 60,
                  height: 4,
                  radius: 2,
                  color: AppColors.whiteA(.5),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniRow extends StatelessWidget {
  const _MiniRow({required this.incoming});

  final bool incoming;

  @override
  Widget build(BuildContext context) {
    final tint = incoming ? AppColors.teal : AppColors.blue;

    return Row(
      children: [
        Container(
          width: 18,
          height: 18,
          decoration: BoxDecoration(
            color: tint.withValues(alpha: .16),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: tint.withValues(alpha: incoming ? .28 : .30),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Skeleton.slate(height: 4, radius: 2, alpha: .22, expand: true),
        const SizedBox(width: 8),
        Skeleton(
          width: incoming ? 26 : 22,
          height: 5,
          radius: 3,
          color: incoming
              ? AppColors.teal
              : AppColors.slate.withValues(alpha: .45),
        ),
      ],
    );
  }
}

class ArtCustomQr extends StatelessWidget {
  const ArtCustomQr({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingArt(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const AppIcon(
                'arrow_left_thin',
                size: 13,
                color: AppColors.inkSoft,
              ),
              const SizedBox(width: 8),
              Skeleton.slate(width: 54, height: 5, radius: 3, alpha: .35),
            ],
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Skeleton.slate(width: 70, height: 4, radius: 2, alpha: .16),
              const SizedBox(height: 7),
              Text(
                'Rs 5,000',
                style: AppText.title.copyWith(
                  fontSize: 21,
                  letterSpacing: -0.9,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 7),
              const Skeleton(
                height: 2,
                radius: 2,
                gradient: AppGradients.primary,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              for (var i = 0; i < 2; i++) ...[
                if (i > 0) const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.whiteA(.72),
                      borderRadius: BorderRadius.circular(AppRadii.xs),
                      border: Border.all(color: AppColors.slateA(.08)),
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.whiteA(.70),
                borderRadius: BorderRadius.circular(AppRadii.chip),
                border: Border.all(color: AppColors.slateA(.07)),
              ),
              child: const AppIcon('qr_large', size: 62),
            ),
          ),
          const SizedBox(height: 12),
          Container(
            height: 30,
            decoration: BoxDecoration(
              gradient: AppGradients.primary,
              borderRadius: BorderRadius.circular(AppRadii.xs),
              boxShadow: AppShadows.chip,
            ),
          ),
        ],
      ),
    );
  }
}

class ArtHistory extends StatelessWidget {
  const ArtHistory({super.key});

  static const _rows = [true, false, true, false, true];

  @override
  Widget build(BuildContext context) {
    return OnboardingArt(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              const AppIcon(
                'arrow_left_thin',
                size: 13,
                color: AppColors.inkSoft,
              ),
              const SizedBox(width: 8),
              Skeleton.slate(width: 64, height: 5, radius: 3, alpha: .35),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              _MiniChip(label: 'ALL', active: true),
              SizedBox(width: 6),
              _MiniChip(label: 'RECEIVED'),
              SizedBox(width: 6),
              _MiniChip(label: 'SENT'),
            ],
          ),
          const SizedBox(height: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.whiteA(.70),
                borderRadius: BorderRadius.circular(AppRadii.chip),
                border: Border.all(color: AppColors.slateA(.07)),
              ),
              child: Column(
                children: [
                  for (var i = 0; i < _rows.length; i++) ...[
                    if (i > 0) const SizedBox(height: 14),
                    _MiniHistoryRow(incoming: _rows[i], seed: i),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.label, this.active = false});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: active ? AppGradients.primary : null,
        color: active ? null : AppColors.slateA(.055),
        borderRadius: BorderRadius.circular(8),
        border: active ? null : Border.all(color: AppColors.slateA(.09)),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontFamily: 'Inter',
          fontSize: 7,
          fontWeight: FontWeight.w600,
          height: 1.0,
          color: active ? AppColors.white : AppColors.inkSoft,
        ),
      ),
    );
  }
}

class _MiniHistoryRow extends StatelessWidget {
  const _MiniHistoryRow({required this.incoming, required this.seed});

  final bool incoming;
  final int seed;

  static const _titleWidths = [54.0, 46.0, 58.0, 50.0, 44.0];

  static const _subWidths = [32.0, 30.0, 26.0, 34.0, 28.0];

  @override
  Widget build(BuildContext context) {
    final tint = incoming ? AppColors.teal : AppColors.blue;

    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          decoration: BoxDecoration(
            color: tint.withValues(alpha: .16),
            borderRadius: BorderRadius.circular(7),
            border: Border.all(
              color: tint.withValues(alpha: incoming ? .28 : .30),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Skeleton.slate(
                width: _titleWidths[seed],
                height: 4,
                radius: 2,
                alpha: .30,
              ),
              const SizedBox(height: 4),
              Skeleton.slate(
                width: _subWidths[seed],
                height: 3,
                radius: 2,
                alpha: .11,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Skeleton(
          width: incoming ? 28 : 24,
          height: 5,
          radius: 3,
          color: incoming
              ? AppColors.teal
              : AppColors.slate.withValues(alpha: .45),
        ),
      ],
    );
  }
}
