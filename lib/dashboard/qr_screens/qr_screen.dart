import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_styles.dart';
import '../../utils/app_text.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/detail_panel.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen>
    with SingleTickerProviderStateMixin {
  final MobileScannerController scannerController = MobileScannerController();

  late final AnimationController sweepController;

  Timer? cameraTimer;

  bool scanned = false;
  bool cameraReady = false;

  @override
  void initState() {
    super.initState();

    sweepController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    scannerController.start();

    cameraTimer = Timer(const Duration(milliseconds: 700), () {
      if (mounted) {
        setState(() {
          cameraReady = true;
        });
      }
    });
  }

  @override
  void dispose() {
    cameraTimer?.cancel();
    sweepController.dispose();
    scannerController.dispose();
    super.dispose();
  }

  void onQrDetected(BarcodeCapture capture) {
    if (scanned) return;

    for (final barcode in capture.barcodes) {
      final value = barcode.rawValue;

      if (value != null && value.isNotEmpty) {
        scanned = true;
        scannerController.stop();
        Navigator.pop(context, value);
        break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    const reticle = 262.0;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          MobileScanner(controller: scannerController, onDetect: onQrDetected),
          if (!cameraReady)
            Container(
              color: Colors.black,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 34,
                      height: 34,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        color: AppColors.teal,
                      ),
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'Starting camera...',
                      style: AppText.body.copyWith(
                        color: AppColors.whiteA(.75),
                        fontFamily: 'Inter',
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          if (cameraReady) ...[
            Positioned.fill(
              child: ClipPath(
                clipper: _ScannerBlurClipper(),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
                  child: const SizedBox.expand(),
                ),
              ),
            ),
            const Opacity(
              opacity: 0.35,
              child: DecoratedBox(
                decoration: BoxDecoration(gradient: AppGradients.scanner),
              ),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: RadialGradient(
                  center: const Alignment(0, -0.2),
                  radius: 0.62,
                  colors: [AppColors.blueA(.16), AppColors.blueA(0)],
                ),
              ),
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _GlassButton(
                          icon: 'arrow_left_light',
                          onTap: () => Navigator.pop(context),
                        ),
                        Text(
                          'Scan to pay',
                          style: TextStyle(
                            color: AppColors.white,
                            fontFamily: 'Inter',
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        _GlassButton(
                          icon: 'flash',
                          onTap: () => scannerController.toggleTorch(),
                        ),
                      ],
                    ),
                    const SizedBox(height: 60),
                    SizedBox(
                      width: reticle,
                      height: reticle,
                      child: _Reticle(sweep: sweepController),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Point your camera at any Raast or AsaanPay QR code',
                      textAlign: TextAlign.center,
                      style: AppText.body.copyWith(
                        fontSize: 14.sp,
                        fontFamily: 'Inter',
                        color: AppColors.whiteA(.72),
                      ),
                    ),
                    const Spacer(),
                    DualAction(
                      dark: true,
                      left: (icon: 'gallery', label: 'Gallery'),
                      right: (icon: 'qr', label: 'My QR'),
                      onRight: () {},
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Reticle extends StatelessWidget {
  const _Reticle({required this.sweep});

  final Animation<double> sweep;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.sheet),
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadii.sheet),
                border: Border.all(color: AppColors.whiteA(.12)),
              ),
            ),
          ),
        ),
        for (final corner in _corners)
          Positioned(
            left: corner.x < 0 ? -2 : null,
            right: corner.x > 0 ? -2 : null,
            top: corner.y < 0 ? -2 : null,
            bottom: corner.y > 0 ? -2 : null,
            child: _Corner(alignment: corner),
          ),
        AnimatedBuilder(
          animation: sweep,
          builder: (context, _) {
            return Positioned(
              left: 14,
              right: 14,
              top: 14 + (262 - 28) * sweep.value,
              child: Container(
                height: 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(2),
                  gradient: LinearGradient(
                    colors: [
                      AppColors.tealA(0),
                      AppColors.teal,
                      AppColors.tealA(0),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.tealA(.55),
                      blurRadius: 22,
                      spreadRadius: 4,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  static const _corners = [
    Alignment.topLeft,
    Alignment.topRight,
    Alignment.bottomLeft,
    Alignment.bottomRight,
  ];
}

class _Corner extends StatelessWidget {
  const _Corner({required this.alignment});

  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    const side = BorderSide(color: AppColors.teal, width: 3);

    final left = alignment.x < 0;
    final top = alignment.y < 0;

    const radius = Radius.circular(6);

    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: left && top ? radius : Radius.zero,
          topRight: !left && top ? radius : Radius.zero,
          bottomLeft: left && !top ? radius : Radius.zero,
          bottomRight: !left && !top ? radius : Radius.zero,
        ),
        border: Border(
          left: left ? side : BorderSide.none,
          right: left ? BorderSide.none : side,
          top: top ? side : BorderSide.none,
          bottom: top ? BorderSide.none : side,
        ),
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  const _GlassButton({required this.icon, this.onTap});

  final String icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadii.pill),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 9, sigmaY: 9),
          child: Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.whiteA(.12),
              borderRadius: BorderRadius.circular(AppRadii.pill),
              border: Border.all(color: AppColors.whiteA(.20)),
            ),
            child: AppIcon(icon, size: 20, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}

class _ScannerBlurClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    const scannerSize = 262.0;

    final view = WidgetsBinding.instance.platformDispatcher.views.first;

    final topPadding = view.padding.top;

    final scannerTop = topPadding + 10 + 42 + 40;
    final scannerLeft = (size.width - scannerSize) / 2;

    final scannerRect = RRect.fromRectAndRadius(
      Rect.fromLTWH(scannerLeft, scannerTop, scannerSize, scannerSize),
      const Radius.circular(20),
    );

    final screenPath = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height));

    final scannerPath = Path()..addRRect(scannerRect);

    return Path.combine(PathOperation.difference, screenPath, scannerPath);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
