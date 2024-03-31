import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _emailInputController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final EmailVerificationController _emailVerificationController =
      Get.find<EmailVerificationController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: AppBackgroundWidget(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: size.height / 5,
                  ),
                  Text(
                    'Your Email Address',
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
                  TextFormField(
                    controller: _emailInputController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<EmailVerificationController>(
                        builder: (emailVerificationController) {
                      return Visibility(
                        visible:
                            emailVerificationController.inProgress == false,
                        replacement:
                            const Center(child: CircularProgressIndicator()),
                        child: ElevatedButton(
                          onPressed: () {
                            verifyEmail();
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined),
                        ),
                      );
                    }),
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
                          Get.back();
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

  Future<void> verifyEmail() async {
    final result = await _emailVerificationController
        .verifyEmail(_emailInputController.text);

    if (result) {
      if (mounted) {
        Get.to(() => PinVerificationScreen(
              email: _emailInputController.text,
            ));
      }
    } else {
      setState(() {});
      if (mounted) {
        showSnackBar(context, _emailVerificationController.errorMessage, true);
      }
    }
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    super.dispose();
  }
}
