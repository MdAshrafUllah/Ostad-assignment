import 'package:get/get.dart' as route;
import 'package:taskmanager/import_links.dart';

class NetworkCaller {
  static Future<ResponseObject> getRequest(String url) async {
    try {
      final Response response = await get(Uri.parse(url),
          headers: {'token': AuthController.accessToken ?? ''});
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            isSuccess: true, statusCode: 200, responseBody: decodedResponse);
      } else if (response.statusCode == 401) {
        _moveToSignIn();
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '');
      } else {
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '');
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
          isSuccess: false,
          statusCode: -1,
          responseBody: '',
          errorMessage: e.toString());
    }
  }

  static Future<ResponseObject> postRequest(
      String url, Map<String, dynamic> body,
      {bool neeSignIn = false}) async {
    try {
      final Response response = await post(Uri.parse(url),
          body: jsonEncode(body),
          headers: {
            'Content-type': 'application/json',
            'token': AuthController.accessToken ?? ''
          });
      log(response.statusCode.toString());
      log(response.body.toString());

      if (response.statusCode == 200) {
        final decodedResponse = jsonDecode(response.body);
        return ResponseObject(
            isSuccess: true, statusCode: 200, responseBody: decodedResponse);
      } else if (response.statusCode == 401) {
        if (neeSignIn == true) {
          _moveToSignIn();
        }
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '',
            errorMessage: 'Email or Password is Incorrect');
      } else {
        return ResponseObject(
            isSuccess: false,
            statusCode: response.statusCode,
            responseBody: '');
      }
    } catch (e) {
      log(e.toString());
      return ResponseObject(
          isSuccess: false,
          statusCode: -1,
          responseBody: '',
          errorMessage: e.toString());
    }
  }

  static Future<void> _moveToSignIn() async {
    await AuthController.removeUserData();
    route.Get.offUntil(
        route.GetPageRoute(page: () => const SignInScreen()), (route) => false);
  }
}
