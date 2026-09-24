import 'package:asaanpay_qr/controllers/auth_controller/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/app_colors.dart';
import '../../utils/app_text.dart';
import '../../utils/screen_orbs.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/app_screen.dart';
import '../../widgets/brand.dart';
import '../../widgets/fields.dart';
import '../../widgets/glass.dart';
import '../../widgets/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AuthController());
  }

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      orbs: ScreenOrbs.of('04'),
      scrollable: true,
      topPadding: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const BrandLockup(height: 56),
          const SizedBox(height: 40),
          Text('Welcome back.', style: AppText.hero),
          const SizedBox(height: 12),
          Text(
            'Sign in to your merchant account and start accepting payments '
            'in seconds.',
            style: AppText.body,
          ),
          const SizedBox(height: 32),
          AppField(
            hint: 'Registered mobile number',
            icon: 'phone',
            controller: controller.mobileController,
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 14),
          Obx(
            () => AppField(
              hint: 'Enter password',
              icon: 'lock',
              controller: controller.passController,
              obscure: controller.passHidden.value,
              keyboardType: TextInputType.visiblePassword,
              trailing: GestureDetector(
                onTap: controller.togglePinVisibility,
                behavior: HitTestBehavior.opaque,
                child: const AppIcon(
                  'eye',
                  size: 20,
                  color: AppColors.inkMuted,
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: controller.forgotPin,
              behavior: HitTestBehavior.opaque,
              child: Text(
                'Forgot password?',
                style: AppText.label13.copyWith(color: AppColors.tealDeep),
              ),
            ),
          ),
          const SizedBox(height: 26),
          Obx(
            () => PrimaryButton(
              label: 'Sign In',
              enabled: !controller.isSubmitting.value,
              onTap: controller.signIn,
            ),
          ),
          const SizedBox(height: 28),
          const OrDivider(),
          const SizedBox(height: 28),
          SecondaryButton(
            label: 'Create merchant account',
            onTap: controller.createAccount,
          ),
          const SizedBox(height: 44),
          Center(
            child: Column(
              children: [
                GlassCircle(
                  size: 54,
                  fill: .72,
                  borderAlpha: .11,
                  onTap: controller.signIn,
                  child: const AppIcon(
                    'scan',
                    size: 24,
                    color: AppColors.tealDeep,
                  ),
                ),
                const SizedBox(height: 14),
                Text('Sign in with Face ID', style: AppText.caption),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
