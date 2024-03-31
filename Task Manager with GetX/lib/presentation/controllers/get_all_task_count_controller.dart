import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';

class GetAllTaskCountStatusController extends GetxController {
  CountByStatusWrapper _countByStatusWrapper = CountByStatusWrapper();
  bool _inProgress = false;
  String? _errorMessage;

  bool get inProgress => _inProgress;
  String get errorMessage =>
      _errorMessage ?? 'Get task count by status has been failed';
  CountByStatusWrapper get countByStatusWrapper => _countByStatusWrapper;

  Future<bool> getAllTaskCountByStatus() async {
    _inProgress = true;
    update();
    final response = await NetworkCaller.getRequest(Urls.taskCountByStatus);

    if (response.isSuccess) {
      _countByStatusWrapper =
          CountByStatusWrapper.fromJson(response.responseBody);
      _inProgress = false;
      update();
      return true;
    } else {
      _errorMessage = response.errorMessage;
      _inProgress = false;
      return false;
    }
  }
}
