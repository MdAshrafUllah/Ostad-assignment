import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';

class NewTaskScreen extends StatefulWidget {
  const NewTaskScreen({super.key});

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  late NewTaskListController _newTaskListController;
  late GetAllTaskCountStatusController _getAllTaskCountStatusController;

  final bool _updateTaskStatusInProgress = false;
  final bool _deleteTaskInProgress = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeControllers();
    });
  }

  void _initializeControllers() {
    _getAllTaskCountStatusController =
        Get.find<GetAllTaskCountStatusController>();
    _newTaskListController = Get.find<NewTaskListController>();
    _getDataFromApis();
  }

  void _getDataFromApis() async {
    await _getAllTaskCount();
    await _getAllNewTaskList();
  }

  Future<void> _getAllTaskCount() async {
    final result =
        await _getAllTaskCountStatusController.getAllTaskCountByStatus();
    if (!result && mounted) {
      showSnackBar(
          context, _getAllTaskCountStatusController.errorMessage, true);
    }
  }

  Future<void> _getAllNewTaskList() async {
    final result = await _newTaskListController.getNewTaskList();
    if (!result && mounted) {
      showSnackBar(context, _newTaskListController.errorMessage, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarStyle(true),
      body: AppBackgroundWidget(
        child: Column(
          children: [
            GetBuilder<GetAllTaskCountStatusController>(
                builder: (getAllTaskCountStatus) {
              return Visibility(
                visible: getAllTaskCountStatus.inProgress == false,
                replacement: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: LinearProgressIndicator(),
                ),
                child: taskCounterSection(getAllTaskCountStatus
                        .countByStatusWrapper.listOfTaskByStatusData ??
                    []),
              );
            }),
            Expanded(
              child: GetBuilder<NewTaskListController>(
                  builder: (getAllNewTaskListController) {
                return Visibility(
                  visible: getAllNewTaskListController.inProgress == false &&
                      _deleteTaskInProgress == false &&
                      _updateTaskStatusInProgress == false,
                  replacement: const Center(
                    child: CircularProgressIndicator(),
                  ),
                  child: RefreshIndicator(
                    onRefresh: () async => _getDataFromApis(),
                    child: Visibility(
                      visible: getAllNewTaskListController
                              .newTaskListWrapper.taskList?.isNotEmpty ==
                          true,
                      replacement: emptyList(),
                      child: ListView.builder(
                        itemCount: getAllNewTaskListController
                                .newTaskListWrapper.taskList?.length ??
                            0,
                        itemBuilder: (context, index) {
                          return TaskCard(
                            taskItem: getAllNewTaskListController
                                .newTaskListWrapper.taskList![index],
                            refreshList: () {
                              _getDataFromApis();
                            },
                          );
                        },
                      ),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Get.to(() => const AddNewTaskScreen());

          if (result != null && result == true) {
            _getDataFromApis();
          }
        },
        backgroundColor: AppColor.themeColor,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50))),
        child: const Icon(
          Icons.add,
          color: AppColor.whiteColor,
        ),
      ),
    );
  }

  Widget taskCounterSection(List<TaskByStatusData> listOfTaskCountByStatus) {
    return SizedBox(
      height: 110,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.separated(
          itemCount: listOfTaskCountByStatus.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return TaskCounterCard(
                title: listOfTaskCountByStatus[index].sId ?? '',
                amount: listOfTaskCountByStatus[index].sum ?? 0);
          },
          separatorBuilder: (_, __) {
            return const SizedBox(
              width: 8,
            );
          },
        ),
      ),
    );
  }
}
