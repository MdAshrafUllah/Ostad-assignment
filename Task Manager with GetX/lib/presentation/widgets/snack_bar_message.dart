import 'package:taskmanager/import_links.dart';

void showSnackBar(BuildContext context, String message,
    [bool isError = false]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor:
          isError ? AppColor.redAccentColor : AppColor.themeColor));
}
