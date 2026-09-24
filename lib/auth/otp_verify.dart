import 'package:asaanpay_qr/controllers/auth_controller/login_controller.dart';
import 'package:asaanpay_qr/utils/app_colors.dart';
import 'package:asaanpay_qr/utils/app_text.dart';
import 'package:asaanpay_qr/utils/screen_orbs.dart';
import 'package:asaanpay_qr/widgets/app_screen.dart';
import 'package:asaanpay_qr/widgets/fields.dart';
import 'package:asaanpay_qr/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class OtpVerifyScreen extends StatefulWidget {
  const OtpVerifyScreen({
    super.key,
    required this.verificationToken,
    required this.deviceId,
  });

  final String verificationToken;
  final String deviceId;

  @override
  State<OtpVerifyScreen> createState() => _OtpVerifyScreenState();
}

class _OtpVerifyScreenState extends State<OtpVerifyScreen> {
  final AuthController controller = Get.put(AuthController());

  final emailOtpController = TextEditingController();
  final phoneOtpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      orbs: ScreenOrbs.of('08'),
      scrollable: true,
      topPadding: 12,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Verify your login.', style: AppText.title),
          SizedBox(height: 12.h),
          Text(
            'Enter the OTPs sent to your email and mobile number.',
            style: AppText.body,
          ),
          SizedBox(height: 32.h),
          Text(
            'Email OTP',
            style: AppText.label13.copyWith(color: AppColors.inkSoft),
          ),
          SizedBox(height: 10.h),
          AppField(
            hint: 'Enter email OTP',
            icon: 'lock',
            controller: emailOtpController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 16.h),
          Text(
            'Phone OTP',
            style: AppText.label13.copyWith(color: AppColors.inkSoft),
          ),
          SizedBox(height: 10.h),
          AppField(
            hint: 'Enter phone OTP',
            icon: 'lock',
            controller: phoneOtpController,
            keyboardType: TextInputType.number,
          ),
          SizedBox(height: 30.h),
          Obx(
            () => PrimaryButton(
              label: 'Verify & Sign In',
              enabled: !controller.isSubmitting.value,
              onTap: () {
                controller.verifyOtp(
                  emailOtp: emailOtpController.text.trim(),
                  phoneOtp: phoneOtpController.text.trim(),
                  token: widget.verificationToken,
                  deviceId: widget.deviceId,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailOtpController.dispose();
    phoneOtpController.dispose();
    super.dispose();
  }
}
