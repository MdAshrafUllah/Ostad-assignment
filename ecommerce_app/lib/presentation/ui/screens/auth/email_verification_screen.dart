import 'package:ecommerce_app/application/utility/app_colors.dart';
import 'package:ecommerce_app/presentation/controller/auth/email_verification_screen_controller.dart';
import 'package:ecommerce_app/presentation/ui/screens/auth/otp_verification_screen.dart';
import 'package:ecommerce_app/presentation/ui/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatelessWidget {
  EmailVerificationScreen({super.key});

  final TextEditingController _emailTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Center(
                  child: AppLogo(),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontSize: 24,
                      ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text('Please enter your email address',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: AppColors.greyColor)),
                const SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: _emailTEController,
                  decoration: const InputDecoration(
                      hintText: 'Email', labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (String? text) {
                    String? trimmedText = text?.trim();
                    if (trimmedText == null || trimmedText.isEmpty) {
                      return 'Enter your email address';
                    } else if (!_isValidEmail(trimmedText)) {
                      return 'Enter a valid email address';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: GetBuilder<EmailVerificationScreenController>(
                      builder: (controller) {
                    if (controller.emailVerificationInProgress) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    return ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          verifyEmail(controller);
                        }
                      },
                      child: const Text('Next'),
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyEmail(EmailVerificationScreenController controller) async {
    final response =
        await controller.verifyEmail(_emailTEController.text.trim());
    if (response) {
      Get.to(
          () => OTPVerificationScreen(email: _emailTEController.text.trim()));
    } else {
      Get.snackbar(
        'Failed',
        'Email verification failed! Try again',
        backgroundColor: AppColors.alertColor,
        colorText: AppColors.foregroundColor,
        borderRadius: 10,
      );
    }
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }
}
