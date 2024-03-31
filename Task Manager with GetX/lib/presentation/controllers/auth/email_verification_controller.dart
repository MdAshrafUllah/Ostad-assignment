import 'package:get/get.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';

class EmailVerificationController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? 'Email Verification Process has been failed';

  Future<bool> verifyEmail(String email) async {
    _inProgress = true;
    update();
    final response =
        await NetworkCaller.getRequest(Urls.recoverVerifyEmail(email));
    _inProgress = false;

    if (response.isSuccess) {
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
