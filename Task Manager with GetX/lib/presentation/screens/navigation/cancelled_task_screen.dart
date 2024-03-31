import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  final bool _deleteTaskInProgress = false;
  final bool _updateTaskStatusInProgress = false;
  final CancelTaskListController _cancelTaskListController =
      Get.find<CancelTaskListController>();

  @override
  void initState() {
    super.initState();
    _getAllCanceledTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarStyle(true),
      body: AppBackgroundWidget(
        child: GetBuilder<CancelTaskListController>(
            builder: (cancelTaskListController) {
          return Visibility(
            visible: cancelTaskListController.inProgress == false &&
                _deleteTaskInProgress == false &&
                _updateTaskStatusInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async => _getAllCanceledTaskList(),
              child: Visibility(
                visible: cancelTaskListController
                        .canceledTaskListWrapper.taskList?.isNotEmpty ==
                    true,
                replacement: emptyList(),
                child: ListView.builder(
                  itemCount: cancelTaskListController
                          .canceledTaskListWrapper.taskList?.length ??
                      0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskItem: cancelTaskListController
                          .canceledTaskListWrapper.taskList![index],
                      refreshList: () {
                        _getAllCanceledTaskList();
                      },
                    );
                  },
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> _getAllCanceledTaskList() async {
    final result = await _cancelTaskListController.getAllCanceledTaskList();
    if (!result) {
      if (mounted) {
        showSnackBar(context, _cancelTaskListController.errorMessage, true);
      }
    }
  }
}
