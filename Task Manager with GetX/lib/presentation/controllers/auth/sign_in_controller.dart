import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:taskmanager/data/models/login_response.dart';
import 'package:taskmanager/data/models/response_object.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';
import 'package:taskmanager/presentation/controllers/auth_controller.dart';

class SignInController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Login failed! Try again';

  Future<bool> signIn(String email, String password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "password": password,
    };

    final ResponseObject response =
        await NetworkCaller.postRequest(Urls.login, inputParams);

    _inProgress = false;

    if (response.isSuccess) {
      LoginResponse loginResponse =
          LoginResponse.fromJson(response.responseBody);
      await AuthController.saveUserData(loginResponse.userData!);
      await AuthController.saveToken(loginResponse.token!);
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      update();
      return false;
    }
  }
}
