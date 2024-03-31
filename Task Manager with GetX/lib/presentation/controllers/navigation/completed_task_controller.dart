import 'package:get/get.dart';
import 'package:taskmanager/data/models/task_list_wrapper.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';

class CompletedTaskController extends GetxController {
  TaskListWrapper _completedTaskListWrapper = TaskListWrapper();
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? 'Get Completed task list has been failed';
  TaskListWrapper get completedTaskListWrapper => _completedTaskListWrapper;

  Future<bool> getAllCompletedTaskList() async {
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.completedList);
    if (response.isSuccess) {
      _completedTaskListWrapper =
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
