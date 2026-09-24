import 'package:asaanpay_qr/auth/login_screen.dart';
import 'package:asaanpay_qr/services/auth_api_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {
  final AuthApiService _api = AuthApiService();

  final nameController = TextEditingController();
  final businessController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();

  final passwordHidden = true.obs;
  final isSubmitting = false.obs;

  void togglePasswordVisibility() {
    passwordHidden.toggle();
  }

  Future<void> register() async {
    if (isSubmitting.value) return;

    final name = nameController.text.trim();
    final businessName = businessController.text.trim();
    final email = emailController.text.trim();
    final phone = phoneController.text.trim();
    final address = addressController.text.trim();
    final city = cityController.text.trim();
    final password = passwordController.text;

    if (name.isEmpty) {
      _showError('Please enter your name');
      return;
    }

    if (businessName.isEmpty) {
      _showError('Please enter your business name');
      return;
    }

    if (email.isEmpty) {
      _showError('Please enter your email');
      return;
    }

    if (phone.isEmpty) {
      _showError('Please enter your phone number');
      return;
    }

    if (address.isEmpty) {
      _showError('Please enter your address');
      return;
    }

    if (city.isEmpty) {
      _showError('Please enter your city');
      return;
    }

    if (password.isEmpty) {
      _showError('Please enter your password');
      return;
    }

    isSubmitting.value = true;

    try {
      final response = await _api.register(
        name: name,
        businessName: businessName,
        email: email,
        phone: phone,
        address: address,
        city: city,
        password: password,
      );

      Get.snackbar(
        'Registration Successful',
        response['message']?.toString() ??
            'Your merchant account has been created.',
      );

      Get.off(() => const LoginScreen(), transition: Transition.leftToRight);
    } catch (e) {
      Get.snackbar(
        'Registration Failed',
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void _showError(String message) {
    Get.snackbar('Signup', message);
  }

  @override
  void onClose() {
    nameController.dispose();
    businessController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
