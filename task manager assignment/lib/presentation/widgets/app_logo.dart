import 'package:taskmanager/import_links.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        AssetsPath.appLogoSvg,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
