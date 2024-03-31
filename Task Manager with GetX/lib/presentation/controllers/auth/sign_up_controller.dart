import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:taskmanager/data/models/response_object.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';

class SignUpController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Registration failed! Try again';

  Future<bool> signUp(String email, String firstName, String lastName,
      String mobile, String password) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
      "password": password,
    };

    _inProgress = false;

    final ResponseObject response =
        await NetworkCaller.postRequest(Urls.registration, inputParams);
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
