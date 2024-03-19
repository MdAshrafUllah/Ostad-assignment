import 'package:taskmanager/import_links.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _moveNextScreen();
  }

  Future<void> _moveNextScreen() async {
    await Future.delayed(const Duration(seconds: 2));
    bool validToken = await AuthController.isUserLoggedIn();
    if (mounted) {
      if (validToken) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const MainBottomNavigation()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const SignInScreen()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: AppBackgroundWidget(
      child: AppLogo(),
    ));
  }
}
