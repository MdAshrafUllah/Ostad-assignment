import 'package:get/get.dart';
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
        Get.off(() => const MainBottomNavigation());
      } else {
        Get.off(() => const SignInScreen());
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
