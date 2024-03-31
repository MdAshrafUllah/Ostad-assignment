import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';

class DeletedController extends GetxController {
  String? _errorMessage;
  String get errorMessage => _errorMessage ?? 'Delete task has been failed';
  Future<bool> deleteTaskById(String id) async {
    final response = await NetworkCaller.getRequest(Urls.deleteTask(id));
    if (response.isSuccess) {
      return true;
    } else {
      _errorMessage = response.errorMessage;
      return false;
    }
  }
}
