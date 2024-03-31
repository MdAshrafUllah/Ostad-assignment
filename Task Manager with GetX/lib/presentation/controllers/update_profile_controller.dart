import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';

class UpdateProfileController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? 'Update profile failed! Try again.';

  Future<bool> updateUserProfileData(
      String email, String firstName, String lastName, String mobile,
      {String password = '', XFile? pickedFile}) async {
    String? photo;

    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "email": email,
      "firstName": firstName,
      "lastName": lastName,
      "mobile": mobile,
    };

    if (password.isNotEmpty) {
      inputParams['password'] = password;
    }

    if (pickedFile != null) {
      List<int> bytes = File(pickedFile.path).readAsBytesSync();
      photo = base64Encode(bytes);
      inputParams['photo'] = photo;
    } else {
      UserData? userData = await AuthController.getUserData();
      if (userData != null && userData.photo != null) {
        photo = userData.photo;
        inputParams['photo'] = photo;
      }
    }

    final response =
        await NetworkCaller.postRequest(Urls.profileUpdate, inputParams);
    _inProgress = false;
    if (response.isSuccess) {
      if (response.responseBody['status'] == 'success') {
        UserData userData = UserData(
          email: email,
          firstName: firstName,
          lastName: lastName,
          mobile: mobile,
          photo: photo,
        );
        await AuthController.saveUserData(userData);
      }
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      _inProgress = false;
      update();
      return false;
    }
  }
}
