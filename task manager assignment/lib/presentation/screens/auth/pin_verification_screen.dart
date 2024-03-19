import 'package:taskmanager/import_links.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;

  const PinVerificationScreen({super.key, required this.email});

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {
  final TextEditingController _pinInputController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _verifyEmailOTPInProgress = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AppBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height / 5,
                  ),
                  Text(
                    'Pin Verification',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'A 6 Digit Verification Pin will send to your email address',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  PinCodeTextField(
                    controller: _pinInputController,
                    appContext: context,
                    length: 6,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    keyboardType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(5),
                      fieldHeight: 50,
                      fieldWidth: 40,
                      inactiveColor: AppColor.greyColor,
                      activeColor: AppColor.themeColor,
                      selectedColor: AppColor.themeColor,
                    ),
                    animationDuration: const Duration(milliseconds: 300),
                    onCompleted: (v) {
                      log("Completed");
                    },
                    onChanged: (value) {},
                    beforeTextPaste: (text) {
                      log("Allowing to paste $text");
                      return true;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _verifyEmailOTPInProgress == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          verifyEmailOTP(
                              widget.email, _pinInputController.text);
                        },
                        child: const Text('Verify'),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Have Account?",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignInScreen(),
                            ),
                            (route) => false,
                          );
                        },
                        child: const Text('Sign In'),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> verifyEmailOTP(String email, String otp) async {
    _verifyEmailOTPInProgress = true;
    setState(() {});
    final response =
        await NetworkCaller.getRequest(Urls.recoverVerifyOTP(email, otp));
    _verifyEmailOTPInProgress = false;

    if (response.isSuccess) {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SetPasswordScreen(
              email: email,
              otp: otp,
            ),
          ),
        );
      }
    } else {
      setState(() {});
      if (mounted) {
        showSnackBar(
            context,
            response.errorMessage ??
                'Email OTP Verification Process has been failed');
      }
    }
  }
}
