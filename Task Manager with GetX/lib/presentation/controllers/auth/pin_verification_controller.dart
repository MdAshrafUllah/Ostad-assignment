import 'package:get/get.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';

class PinVerificationController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? 'Email OTP Verification Process has been failed';

  Future<bool> verifyEmailOTP(String email, String otp) async {
    _inProgress = true;
    update();
    final response =
        await NetworkCaller.getRequest(Urls.recoverVerifyOTP(email, otp));
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
