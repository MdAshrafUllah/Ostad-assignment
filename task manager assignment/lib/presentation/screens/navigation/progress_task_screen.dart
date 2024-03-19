import 'package:taskmanager/import_links.dart';

class ProgressTaskScreen extends StatefulWidget {
  const ProgressTaskScreen({super.key});

  @override
  State<ProgressTaskScreen> createState() => _ProgressTaskScreenState();
}

class _ProgressTaskScreenState extends State<ProgressTaskScreen> {
  bool _getProgressTaskListInProgress = false;
  final bool _deleteTaskInProgress = false;
  final bool _updateTaskStatusInProgress = false;
  TaskListWrapper _progressTaskListWrapper = TaskListWrapper();

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
          visible: _getProgressTaskListInProgress == false &&
              _deleteTaskInProgress == false &&
              _updateTaskStatusInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: RefreshIndicator(
            onRefresh: () async => _getAllCanceledTaskList(),
            child: Visibility(
              visible: _progressTaskListWrapper.taskList?.isNotEmpty == true,
              replacement: emptyList(),
              child: ListView.builder(
                itemCount: _progressTaskListWrapper.taskList?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskCard(
                    taskItem: _progressTaskListWrapper.taskList![index],
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
    _getProgressTaskListInProgress = true;
    setState(() {});
    final response = await NetworkCaller.getRequest(Urls.progressList);
    if (response.isSuccess) {
      _progressTaskListWrapper =
          TaskListWrapper.fromJson(response.responseBody);
      _getProgressTaskListInProgress = false;
      setState(() {});
    } else {
      _getProgressTaskListInProgress = false;
      setState(() {});
      if (mounted) {
        showSnackBar(context,
            response.errorMessage ?? 'Get Cancelled task list has been failed');
      }
    }
  }
}
