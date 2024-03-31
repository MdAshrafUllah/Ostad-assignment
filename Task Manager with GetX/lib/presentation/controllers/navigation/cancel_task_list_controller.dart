import 'package:get/get.dart';
import 'package:taskmanager/data/models/task_list_wrapper.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';

class CancelTaskListController extends GetxController {
  TaskListWrapper _canceledTaskListWrapper = TaskListWrapper();
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? 'Get Cancelled task list has been failed';
  TaskListWrapper get canceledTaskListWrapper => _canceledTaskListWrapper;

  Future<bool> getAllCanceledTaskList() async {
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.canceledList);
    if (response.isSuccess) {
      _canceledTaskListWrapper =
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
