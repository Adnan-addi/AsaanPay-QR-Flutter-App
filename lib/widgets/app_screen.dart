import 'package:flutter/material.dart';

import 'bottom_nav.dart';
import 'orb_background.dart';

class AppScreen extends StatelessWidget {
  const AppScreen({
    super.key,
    required this.child,
    this.orbs = Orb.homeDefaults,
    this.bottomNav,
    this.horizontalPadding = 28,
    this.topPadding = 10,
    this.scrollable = false,
  });

  final Widget child;
  final List<Orb> orbs;
  final BottomNav? bottomNav;
  final double horizontalPadding;
  final double topPadding;
  final bool scrollable;

  @override
  Widget build(BuildContext context) {
    final gutter = EdgeInsets.symmetric(horizontal: horizontalPadding);
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    Widget body = Padding(
      padding: gutter.copyWith(top: topPadding),
      child: child,
    );

    if (scrollable) {
      body = SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: gutter.copyWith(
          top: topPadding,
          bottom: bottomNav != null
              ? BottomNav.reservedSpace(context)
              : bottomInset + 24,
        ),
        child: child,
      );
    }
    return Material(
      type: MaterialType.transparency,
      child: OrbBackground(
        orbs: orbs,
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Positioned.fill(child: body),
              if (bottomNav != null)
                Positioned(
                  left: horizontalPadding,
                  right: horizontalPadding,
                  bottom: bottomInset + 12,
                  child: bottomNav!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
