import 'package:get/get.dart';
import 'package:taskmanager/data/models/task_list_wrapper.dart';
import 'package:taskmanager/data/services/network_caller.dart';
import 'package:taskmanager/data/utility/urls.dart';

class NewTaskListController extends GetxController {
  TaskListWrapper _newTaskListWrapper = TaskListWrapper();
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? 'Get new task list has been failed';

  TaskListWrapper get newTaskListWrapper => _newTaskListWrapper;

  Future<bool> getNewTaskList() async {
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.newTaskList);
    if (response.isSuccess) {
      _newTaskListWrapper = TaskListWrapper.fromJson(response.responseBody);
      // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      // sharedPreferences.setString('newTask', _newTaskListWrapper.toString());
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
