import 'package:get/get.dart';
import 'package:taskmanager/data/models/task_list_wrapper.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';

class ProgressTaskListController extends GetxController {
  TaskListWrapper _progressTaskListWrapper = TaskListWrapper();
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? 'Get Progress task list has been failed';
  TaskListWrapper get progressTaskListWrapper => _progressTaskListWrapper;

  Future<bool> getAllProgressTaskList() async {
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.progressList);
    if (response.isSuccess) {
      _progressTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
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
