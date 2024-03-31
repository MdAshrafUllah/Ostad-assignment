import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';
import 'package:taskmanager/presentation/controllers/deleted_task_card_controller.dart';
import 'package:taskmanager/presentation/controllers/update_task_card_controller.dart';

class ControllerBinder extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignInController());
    Get.lazyPut(() => SignUpController());
    Get.put(EmailVerificationController());
    Get.put(PinVerificationController());
    Get.put(SetPasswordController());
    Get.put(GetAllTaskCountStatusController());
    Get.put(NewTaskListController());
    Get.lazyPut(() => CompletedTaskController());
    Get.lazyPut(() => CancelTaskListController());
    Get.lazyPut(() => ProgressTaskListController());
    Get.put(AddNewTaskController());
    Get.put(UpdateProfileController());
    Get.put(UpdateController());
    Get.put(DeletedController());
  }
}
