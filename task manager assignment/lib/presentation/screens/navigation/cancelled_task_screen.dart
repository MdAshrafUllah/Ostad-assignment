import 'package:taskmanager/import_links.dart';

class CancelledTaskScreen extends StatefulWidget {
  const CancelledTaskScreen({super.key});

  @override
  State<CancelledTaskScreen> createState() => _CancelledTaskScreenState();
}

class _CancelledTaskScreenState extends State<CancelledTaskScreen> {
  bool _getCancelledTaskListInProgress = false;
  final bool _deleteTaskInProgress = false;
  final bool _updateTaskStatusInProgress = false;
  TaskListWrapper _canceledTaskListWrapper = TaskListWrapper();

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
        child: Visibility(
          visible: _getCancelledTaskListInProgress == false &&
              _deleteTaskInProgress == false &&
              _updateTaskStatusInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: () async => _getAllCanceledTaskList(),
            child: Visibility(
              visible: _canceledTaskListWrapper.taskList?.isNotEmpty == true,
              replacement: emptyList(),
              child: ListView.builder(
                itemCount: _canceledTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskItem: _canceledTaskListWrapper.taskList![index],
                    refreshList: () {
                      _getAllCanceledTaskList();
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

  Future<void> _getAllCanceledTaskList() async {
    _getCancelledTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.canceledList);
    if (response.isSuccess) {
      _canceledTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getCancelledTaskListInProgress = false;
      setState(() {});
    } else {
      _getCancelledTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBar(context,
            response.errorMessage ?? 'Get Cancelled task list has been failed');
      }
    }
  }
}
