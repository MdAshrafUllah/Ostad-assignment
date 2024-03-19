import 'package:taskmanager/import_links.dart';

class CompleteTaskScreen extends StatefulWidget {
  const CompleteTaskScreen({super.key});

  @override
  State<CompleteTaskScreen> createState() => _CompleteTaskScreenState();
}

class _CompleteTaskScreenState extends State<CompleteTaskScreen> {
  bool _getNewTaskListInProgress = false;
  final bool _deleteTaskInProgress = false;
  final bool _updateTaskStatusInProgress = false;
  TaskListWrapper _completedTaskListWrapper = TaskListWrapper();

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
        child: Visibility(
          visible: _getNewTaskListInProgress == false &&
              _deleteTaskInProgress == false &&
              _updateTaskStatusInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: () async => _getAllCompletedTaskList(),
            child: Visibility(
              visible: _completedTaskListWrapper.taskList?.isNotEmpty == true,
              replacement: emptyList(),
              child: ListView.builder(
                itemCount: _completedTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskItem: _completedTaskListWrapper.taskList![index],
                    refreshList: () {
                      _getAllCompletedTaskList();
                    },
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _getAllCompletedTaskList() async {
    _getNewTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.completedList);
    if (response.isSuccess) {
      _completedTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getNewTaskListInProgress = false;
      setState(() {});
    } else {
      _getNewTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBar(context,
            response.errorMessage ?? 'Get Completed task list has been failed');
      }
    }
  }
}
