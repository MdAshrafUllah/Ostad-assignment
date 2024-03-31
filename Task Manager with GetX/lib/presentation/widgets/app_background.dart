import 'package:taskmanager/import_links.dart';

class AppBackgroundWidget extends StatelessWidget {
  const AppBackgroundWidget({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SvgPicture.asset(
            AssetsPath.appBackgroundSvg,
            height: double.infinity,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          child
        ],
      ),
    );
  }
}
