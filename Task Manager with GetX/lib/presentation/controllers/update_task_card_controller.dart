import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';

class UpdateController extends GetxController {
  String? _errorMessage;
  String get errorMessage =>
      _errorMessage ?? 'Update task status has been failed';
  Future<bool> updateTaskById(String id, String status) async {
    final response =
        await NetworkCaller.getRequest(Urls.updateTaskStatus(id, status));
    if (response.isSuccess) {
      return true;
    } else {
      _errorMessage = response.errorMessage;
      return false;
    }
  }
}
