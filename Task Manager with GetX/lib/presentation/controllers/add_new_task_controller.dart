import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';

class AddNewTaskController extends GetxController {
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage => _errorMessage ?? 'Add New Task Failed';

  Future<bool> addNewTask(String title, String description) async {
    _inProgress = true;
    update();

    Map<String, dynamic> inputParams = {
      "title": title,
      "description": description,
      "status": "New"
    };

    final response =
        await NetworkCaller.postRequest(Urls.createTask, inputParams);

    if (response.isSuccess) {
      _inProgress = false;
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
