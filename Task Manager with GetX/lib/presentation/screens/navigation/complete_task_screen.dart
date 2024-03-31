import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  final CompletedTaskController _completedTaskController =
      Get.find<CompletedTaskController>();
  final bool _deleteTaskInProgress = false;
  final bool _updateTaskStatusInProgress = false;

  @override
  void initState() {
    super.initState();
    _getAllCompletedTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarStyle(true),
      body: AppBackgroundWidget(
        child: GetBuilder<CompletedTaskController>(
            builder: (completedTaskController) {
          return Visibility(
            visible: completedTaskController.inProgress == false &&
                _deleteTaskInProgress == false &&
                _updateTaskStatusInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async => _getAllCompletedTaskList(),
              child: Visibility(
                visible: _completedTaskController
                        .completedTaskListWrapper.taskList?.isNotEmpty ==
                    true,
                replacement: emptyList(),
                child: ListView.builder(
                  itemCount: _completedTaskController
                          .completedTaskListWrapper.taskList?.length ??
                      0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskItem: _completedTaskController
                          .completedTaskListWrapper.taskList![index],
                      refreshList: () {
                        _getAllCompletedTaskList();
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

  Future<void> _getAllCompletedTaskList() async {
    final result = await _completedTaskController.getAllCompletedTaskList();
    if (!result) {
      if (mounted) {
        showSnackBar(context, _completedTaskController.errorMessage, true);
      }
    }
  }
}
