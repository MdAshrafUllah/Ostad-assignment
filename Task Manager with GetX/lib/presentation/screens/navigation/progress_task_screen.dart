import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  final ProgressTaskListController _progressTaskListController =
      Get.find<ProgressTaskListController>();
  final bool _deleteTaskInProgress = false;
  final bool _updateTaskStatusInProgress = false;

  @override
  void initState() {
    super.initState();
    _getAllProgressTaskList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarStyle(true),
      body: AppBackgroundWidget(
        child: GetBuilder<ProgressTaskListController>(
            builder: (progressTaskListController) {
          return Visibility(
            visible: progressTaskListController.inProgress == false &&
                _deleteTaskInProgress == false &&
                _updateTaskStatusInProgress == false,
            replacement: const Center(
              child: CircularProgressIndicator(),
            ),
            child: RefreshIndicator(
              onRefresh: () async => _getAllProgressTaskList(),
              child: Visibility(
                visible: progressTaskListController
                        .progressTaskListWrapper.taskList?.isNotEmpty ==
                    true,
                replacement: emptyList(),
                child: ListView.builder(
                  itemCount: progressTaskListController
                          .progressTaskListWrapper.taskList?.length ??
                      0,
                  itemBuilder: (context, index) {
                    return TaskCard(
                      taskItem: progressTaskListController
                          .progressTaskListWrapper.taskList![index],
                      refreshList: () {
                        _getAllProgressTaskList();
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

  Future<void> _getAllProgressTaskList() async {
    final result = await _progressTaskListController.getAllProgressTaskList();
    if (!result) {
      if (mounted) {
        showSnackBar(context, _progressTaskListController.errorMessage, true);
      }
    }
  }
}
