import 'package:get/get.dart';
import 'package:taskmanager/data/models/response_object.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';

class SetPasswordController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? 'Reset Password Process has been failed';

  Future<bool> resetPassword(String email, String otp, String password) async {
    _inProgress = true;
    update();
    Map<String, dynamic> inputParams = {
      "email": email,
      "OTP": otp,
      "password": password,
    };

    final ResponseObject response =
        await NetworkCaller.postRequest(Urls.recoverResetPassword, inputParams);

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
