import 'package:asaanpay_qr/auth/otp_verify.dart';
import 'package:asaanpay_qr/auth/signup_screen.dart';
import 'package:asaanpay_qr/dashboard/dashboard.dart';
import 'package:asaanpay_qr/services/auth_api_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthApiService _api = AuthApiService();

  final mobileController = TextEditingController();
  final passController = TextEditingController();

  final passHidden = true.obs;
  final isSubmitting = false.obs;

  String? verificationToken;

  void togglePinVisibility() {
    passHidden.toggle();
  }

  Future<void> signIn() async {
    if (isSubmitting.value) return;

    final phone = mobileController.text.trim();
    final password = passController.text;

    if (phone.isEmpty) {
      Get.snackbar('Login', 'Please enter your mobile number');
      return;
    }

    if (password.isEmpty) {
      Get.snackbar('Login', 'Please enter your password');
      return;
    }

    isSubmitting.value = true;

    try {
      final response = await _api.login(
        phone: phone,
        password: password,
        deviceId: 'flutter_android_device',
      );

      verificationToken =
          response['verification_token']?.toString() ??
          response['data']?['verification_token']?.toString();

      if (verificationToken == null || verificationToken!.isEmpty) {
        Get.snackbar(
          'Login',
          response['message']?.toString() ?? 'Verification token not received',
        );
        return;
      }

      Get.to(
        () => OtpVerifyScreen(
          verificationToken: verificationToken!,
          deviceId: 'flutter_android_device',
        ),
        transition: Transition.rightToLeft,
      );
    } catch (e) {
      Get.snackbar(
        'Login Failed',
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  Future<void> verifyOtp({
    required String emailOtp,
    required String phoneOtp,
    required String token,
    required String deviceId,
  }) async {
    if (isSubmitting.value) return;

    if (emailOtp.isEmpty || phoneOtp.isEmpty) {
      Get.snackbar('OTP', 'Please enter both OTPs');
      return;
    }

    isSubmitting.value = true;

    try {
      final response = await _api.verifyOtp(
        verificationToken: token,
        emailOtp: emailOtp,
        phoneOtp: phoneOtp,
        deviceId: deviceId,
      );

      Get.snackbar(
        'Success',
        response['message']?.toString() ?? 'Login successful',
      );

      Get.offAll(() => const Dashboard());
    } catch (e) {
      Get.snackbar(
        'OTP Verification Failed',
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void createAccount() {
    Get.to(() => const SignupScreen(), transition: Transition.rightToLeft);
  }

  void forgotPin() {}

  void submitReset() {}

  @override
  void onClose() {
    mobileController.dispose();
    passController.dispose();
    super.onClose();
  }
}
