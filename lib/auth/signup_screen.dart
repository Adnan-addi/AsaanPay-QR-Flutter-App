import 'package:asaanpay_qr/services/auth_api_service.dart';
import 'package:asaanpay_qr/utils/app_colors.dart';
import 'package:asaanpay_qr/utils/app_styles.dart';
import 'package:asaanpay_qr/utils/app_text.dart';
import 'package:asaanpay_qr/utils/screen_orbs.dart';
import 'package:asaanpay_qr/widgets/app_icon.dart';
import 'package:asaanpay_qr/widgets/app_screen.dart';
import 'package:asaanpay_qr/widgets/chips.dart';
import 'package:asaanpay_qr/widgets/fields.dart';
import 'package:asaanpay_qr/widgets/glass.dart';
import 'package:asaanpay_qr/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final AuthApiService api = AuthApiService();

  final nameController = TextEditingController();
  final businessController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();

  final passwordHidden = true.obs;
  final isSubmitting = false.obs;

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
      Get.snackbar('Signup', 'Please enter your name');
      return;
    }

    if (businessName.isEmpty) {
      Get.snackbar('Signup', 'Please enter your business name');
      return;
    }

    if (email.isEmpty) {
      Get.snackbar('Signup', 'Please enter your email');
      return;
    }

    if (phone.isEmpty) {
      Get.snackbar('Signup', 'Please enter your phone number');
      return;
    }

    if (address.isEmpty) {
      Get.snackbar('Signup', 'Please enter your address');
      return;
    }

    if (city.isEmpty) {
      Get.snackbar('Signup', 'Please enter your city');
      return;
    }

    if (password.isEmpty) {
      Get.snackbar('Signup', 'Please enter your password');
      return;
    }

    isSubmitting.value = true;

    try {
      final response = await api.register(
        name: name,
        businessName: businessName,
        email: email,
        phone: phone,
        address: address,
        city: city,
        password: password,
      );

      Get.snackbar(
        'Registration',
        response['message']?.toString() ??
            'Merchant account created successfully',
      );

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Signup Failed',
        e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      isSubmitting.value = false;
    }
  }

  void togglePasswordVisibility() {
    passwordHidden.toggle();
  }

  @override
  Widget build(BuildContext context) {
    return SignupScaffold(
      orbId: '08',
      step: 1,
      title: "Let's create your account.",
      subtitle: 'Enter your merchant details to get started.',
      actionLabel: 'Create Account',
      onAction: register,
      actionEnabled: !isSubmitting.value,
      children: [
        LabeledField(
          label: 'Name',
          child: AppField(
            hint: 'Enter your name',
            icon: 'user',
            controller: nameController,
            keyboardType: TextInputType.name,
          ),
        ),
        SizedBox(height: 10.h),
        LabeledField(
          label: 'Business Name',
          child: AppField(
            hint: 'Enter your business name',
            icon: 'briefcase',
            controller: businessController,
            keyboardType: TextInputType.text,
          ),
        ),
        SizedBox(height: 10.h),
        LabeledField(
          label: 'Email',
          child: AppField(
            hint: 'Enter your email',
            icon: 'email',
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
          ),
        ),
        SizedBox(height: 10.h),
        LabeledField(
          label: 'Phone',
          child: AppField(
            hint: '03xx-xxxxxxx',
            icon: 'phone',
            controller: phoneController,
            keyboardType: TextInputType.phone,
          ),
        ),
        SizedBox(height: 10.h),
        LabeledField(
          label: 'Address',
          child: AppField(
            hint: 'Enter your address',
            icon: 'address',
            controller: addressController,
            keyboardType: TextInputType.streetAddress,
          ),
        ),
        SizedBox(height: 10.h),
        LabeledField(
          label: 'City',
          child: AppField(
            hint: 'Enter your city',
            icon: 'city',
            controller: cityController,
            keyboardType: TextInputType.text,
          ),
        ),
        SizedBox(height: 10.h),
        LabeledField(
          label: 'Password',
          child: Obx(
            () => AppField(
              hint: 'Enter your password',
              icon: 'lock',
              controller: passwordController,
              obscure: passwordHidden.value,
              keyboardType: TextInputType.visiblePassword,
              trailing: GestureDetector(
                onTap: togglePasswordVisibility,
                behavior: HitTestBehavior.opaque,
                child: const AppIcon(
                  'eye',
                  size: 20,
                  color: AppColors.inkMuted,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    businessController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    cityController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

class SignupScaffold extends StatelessWidget {
  const SignupScaffold({
    super.key,
    required this.step,
    required this.title,
    required this.children,
    this.orbId,
    this.subtitle,
    this.actionLabel = 'Continue',
    this.onAction,
    this.actionEnabled = true,
    this.footer,
    this.totalSteps = 3,
  });

  final int step;
  final int totalSteps;
  final String title;
  final String? subtitle;
  final List<Widget> children;
  final String? orbId;
  final String actionLabel;
  final VoidCallback? onAction;
  final bool actionEnabled;
  final Widget? footer;

  @override
  Widget build(BuildContext context) {
    final keyboardInset = MediaQuery.viewInsetsOf(context).bottom;

    return AppScreen(
      orbs: ScreenOrbs.of(orbId ?? '08'),
      topPadding: 10,
      child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        padding: EdgeInsets.only(bottom: keyboardInset + 40.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => Navigator.maybePop(context),
                  behavior: HitTestBehavior.opaque,
                  child: GlassCard(
                    width: 42,
                    height: 42,
                    radius: AppRadii.pill,
                    fill: .72,
                    borderAlpha: .10,
                    blur: 24,
                    child: const Center(child: AppIcon('arrow_left', size: 20)),
                  ),
                ),
                Text(
                  'Step $step of $totalSteps',
                  style: AppText.label13Semi.copyWith(
                    color: AppColors.blueDeep,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            StepProgress(value: step / totalSteps),
            const SizedBox(height: 34),
            Text(title, style: AppText.title),
            if (subtitle != null) ...[
              const SizedBox(height: 12),
              Text(subtitle!, style: AppText.body),
            ],
            const SizedBox(height: 32),
            ...children,
            const SizedBox(height: 16),
            if (footer != null) ...[footer!, const SizedBox(height: 20)],
            SizedBox(height: 30.h),
            Obx(
              () => PrimaryButton(
                label: actionLabel,
                onTap: onAction,
                enabled: actionEnabled,
              ),
            ),
            SizedBox(height: 40.h),
          ],
        ),
      ),
    );
  }
}

class LabeledField extends StatelessWidget {
  const LabeledField({super.key, required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(label, style: AppText.label13.copyWith(color: AppColors.inkSoft)),
        const SizedBox(height: 10),
        child,
      ],
    );
  }
}
