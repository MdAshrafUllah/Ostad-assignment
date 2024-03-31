import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignInController _signInController = Get.find<SignInController>();
  bool _isVisible = false;

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
                    'Get Start With',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: _emailInputController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Your Email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passwordInputController,
                    obscureText: !_isVisible,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isVisible ? Icons.visibility : Icons.visibility_off,
                          color: AppColor.themeColor,
                        ),
                        onPressed: () {
                          setState(() {
                            _isVisible = !_isVisible;
                          });
                        },
                      ),
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Your Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: GetBuilder<SignInController>(
                        builder: (signInController) {
                      return Visibility(
                        visible: signInController.inProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(
                            color: AppColor.themeColor,
                          ),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _isLogin();
                              }
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      );
                    }),
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.to(() => const EmailVerificationScreen());
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: AppColor.greyColor,
                      ),
                      child: const Text('Forget Password?'),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have Account?",
                        style: Theme.of(context).textTheme.displaySmall,
                      ),
                      TextButton(
                        onPressed: () {
                          Get.to(() => const SignUpScreen());
                        },
                        child: const Text('Sign Up'),
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

  Future<void> _isLogin() async {
    final result = await _signInController.signIn(
        _emailInputController.text.trim(), _passwordInputController.text);

    if (result) {
      if (mounted) {
        showSnackBar(context, 'Login Successful');
        if (mounted) {
          Get.offUntil(GetPageRoute(page: () => const MainBottomNavigation()),
              (route) => false);
        }
      }
    } else {
      if (mounted) {
        showSnackBar(context, _signInController.errorMessage, true);
      }
    }
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }
}
