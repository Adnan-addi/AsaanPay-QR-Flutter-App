import 'package:asaanpay_qr/auth/login_screen.dart';
import 'package:asaanpay_qr/onboarding/onboard_screen.dart';
import 'package:asaanpay_qr/utils/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  final prefs = await SharedPreferences.getInstance();
  final onboardingSeen = prefs.getBool('onboarding_seen') ?? false;

  runApp(MyApp(onboardingSeen: onboardingSeen));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.onboardingSeen});

  final bool onboardingSeen;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'AsaanPay QR',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          defaultTransition: Transition.cupertino,
          home: onboardingSeen ? const LoginScreen() : const OnboardingScreen(),
        );
      },
    );
  }
}
