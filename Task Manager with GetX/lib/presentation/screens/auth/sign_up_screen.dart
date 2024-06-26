import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _fNameInputController = TextEditingController();
  final TextEditingController _lNameInputController = TextEditingController();
  final TextEditingController _mobileInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignUpController _signUpController = Get.find<SignUpController>();
  bool _isVisible = false;

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
                  height: size.height / 6,
                ),
                Text('Join With Us',
                    style: Theme.of(context).textTheme.titleLarge),
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
                  controller: _fNameInputController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter Your First Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _lNameInputController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter Your Last Name';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _mobileInputController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Mobile',
                  ),
                  validator: (String? value) {
                    if (value?.trim().isEmpty ?? true) {
                      return 'Enter Your Mobile';
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
                    if (value!.length < 6) {
                      return 'Minimum 6 characters length';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child:
                      GetBuilder<SignUpController>(builder: (signUpController) {
                    return Visibility(
                      visible: signUpController.inProgress == false,
                      replacement: const Center(
                        child: CircularProgressIndicator(),
                      ),
                      child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _signUp();
                            }
                          },
                          child: const Icon(Icons.arrow_circle_right_outlined)),
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
                        Get.to(() => const SignInScreen());
                      },
                      child: const Text('Sign In'),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Future<void> _signUp() async {
    final result = await _signUpController.signUp(
        _emailInputController.text.trim(),
        _fNameInputController.text.trim(),
        _lNameInputController.text.trim(),
        _mobileInputController.text.trim(),
        _passwordInputController.text);

    if (result) {
      if (mounted) {
        showSnackBar(context, 'Registration Successful');
        Get.back();
      }
    } else {
      if (mounted) {
        showSnackBar(context, _signUpController.errorMessage, true);
      }
    }
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _fNameInputController.dispose();
    _lNameInputController.dispose();
    _mobileInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }
}
