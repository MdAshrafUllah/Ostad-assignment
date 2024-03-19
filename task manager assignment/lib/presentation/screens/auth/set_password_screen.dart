import 'package:taskmanager/import_links.dart';

class SetPasswordScreen extends StatefulWidget {
  final String otp;
  final String email;

  const SetPasswordScreen({super.key, required this.otp, required this.email});

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  final TextEditingController _passOneInputController = TextEditingController();
  final TextEditingController _passTwoInputController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isRecoverResetPasswordProgress = false;
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
                    'Set Password',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Minimum Length Password 8 Character with Latter and number combination',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passOneInputController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Password',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  TextFormField(
                    controller: _passTwoInputController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      hintText: 'Confirm Password',
                    ),
                    validator: (String? value) {
                      if (value?.trim().isEmpty ?? true) {
                        return 'Enter Confirm Password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Visibility(
                      visible: _isRecoverResetPasswordProgress == false,
                      replacement:
                          const Center(child: CircularProgressIndicator()),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_passOneInputController.text ==
                                _passTwoInputController.text) {
                              _recoverResetPassword();
                            } else {
                              showSnackBar(context,
                                  'Password Not Match. Try Again', true);
                            }
                          }
                        },
                        child: const Text('Confirm'),
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
                                  builder: (context) => const SignInScreen()),
                              (route) => false);
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

  void _recoverResetPassword() async {
    setState(() {
      _isRecoverResetPasswordProgress = true;
    });

    String? password = _passTwoInputController.text;
    if (password.isNotEmpty) {
      Map<String, dynamic> inputParams = {
        "email": widget.email,
        "OTP": widget.otp,
        "password": password,
      };

      final ResponseObject response = await NetworkCaller.postRequest(
          Urls.recoverResetPassword, inputParams);

      setState(() {
        _isRecoverResetPasswordProgress = false;
      });

      if (mounted) {
        if (response.isSuccess) {
          showSnackBar(context, 'Password Reset Successful');
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const SignInScreen()),
            (route) => false,
          );
        } else {
          showSnackBar(
              context,
              response.errorMessage ??
                  'Password Reset Operation is Failed. Try Again',
              true);
        }
      }
    }
  }

  @override
  void dispose() {
    _passOneInputController.dispose();
    _passTwoInputController.dispose();
    super.dispose();
  }
}
