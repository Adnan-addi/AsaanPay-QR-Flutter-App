import 'package:asaanpay_qr/dashboard/card_screen.dart';
import 'package:asaanpay_qr/dashboard/history.dart';
import 'package:asaanpay_qr/dashboard/home.dart';
import 'package:asaanpay_qr/dashboard/profile_screen.dart';
import 'package:asaanpay_qr/dashboard/qr_screens/qr_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/bottom_nav.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Stack(
        children: [
          IndexedStack(
            index: currentIndex,
            children: const [
              HomeScreen(showNav: false),
              HistoryScreen(),
              CardsScreen(showNav: false),
              ProfileScreen(showNav: false),
            ],
          ),
          Positioned(
            left: 28,
            right: 28,
            bottom: MediaQuery.paddingOf(context).bottom + 12,
            child: BottomNav(
              current: NavTab.values[currentIndex],
              onSelect: (tab) {
                setState(() {
                  currentIndex = NavTab.values.indexOf(tab);
                });
              },
              onScan: () {
                Get.to(
                  () => ScanQrScreen(),
                  transition: Transition.rightToLeft,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
