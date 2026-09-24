import 'package:asaanpay_qr/widgets/chips.dart';
import 'package:asaanpay_qr/widgets/settings_row.dart';
import 'package:flutter/material.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../utils/app_text.dart';
import '../../utils/screen_orbs.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_screen.dart';
import '../../widgets/detail_panel.dart';
import '../../widgets/glass.dart';
import '../../widgets/top_bar.dart';

class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({
    super.key,
    this.onShare,
    this.onReceipt,
    this.onDispute,
  });

  final VoidCallback? onShare;
  final VoidCallback? onReceipt;
  final VoidCallback? onDispute;

  static const timeline = [
    ('QR scanned', '01:33 PM'),
    ('Payment authorised', '01:34 PM'),
    ('Credited to your balance', '01:34 PM'),
  ];

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      orbs: ScreenOrbs.of('25'),
      scrollable: true,
      topPadding: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TopBar(
            title: 'Details',
            trailing: GestureDetector(
              onTap: onShare,
              behavior: HitTestBehavior.opaque,
              child: GlassCard(
                width: 42,
                height: 42,
                radius: AppRadii.pill,
                fill: .72,
                borderAlpha: .10,
                blur: 24,
                child: const Center(child: AppIcon('share', size: 19)),
              ),
            ),
          ),
          const SizedBox(height: 26),
          Column(
            children: [
              Container(
                width: 66,
                height: 66,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.tealA(.13),
                  borderRadius: BorderRadius.circular(AppRadii.bubble),
                  border: Border.all(color: AppColors.tealA(.28)),
                ),
                child: const AppIcon(
                  'money_in',
                  size: 30,
                  color: AppColors.tealDeep,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                '+ Rs 27,000',
                style: AppText.balance.copyWith(color: AppColors.tealDeep),
              ),
              const SizedBox(height: 8),
              Text('Payment received', style: AppText.body13),
              const SizedBox(height: 10),
              const StatusPill(label: 'COMPLETED'),
            ],
          ),
          const SizedBox(height: 20),
          const DetailPanel(
            rows: [
              DetailRow('Paid by', 'Ahmed Raza'),
              DetailRow('Method', 'Raast QR'),
              DetailRow('Date & time', '1 Sep 2026, 01:34 PM'),
              DetailRow('Reference', 'RST-8842-01LK'),
              DetailRow('Fee', 'Rs 0'),
            ],
          ),
          const SizedBox(height: 24),
          const Eyebrow('TIMELINE'),
          const SizedBox(height: 12),
          GlassCard(
            radius: AppRadii.panel,
            padding: const EdgeInsets.fromLTRB(20, 18, 20, 18),
            child: Column(
              children: [
                for (var i = 0; i < timeline.length; i++)
                  _TimelineStep(
                    label: timeline[i].$1,
                    time: timeline[i].$2,
                    isLast: i == timeline.length - 1,
                  ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          DualAction(
            left: (icon: 'download', label: 'Receipt'),
            right: (icon: 'help_circle', label: 'Dispute'),
            onLeft: onReceipt,
            onRight: onDispute,
          ),
        ],
      ),
    );
  }
}

class _TimelineStep extends StatelessWidget {
  const _TimelineStep({
    required this.label,
    required this.time,
    required this.isLast,
  });

  final String label;
  final String time;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.only(top: 4),
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppGradients.diagonal,
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                    color: AppColors.slateA(.10),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppText.label14),
                  const SizedBox(height: 3),
                  Text(time, style: AppText.caption),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
