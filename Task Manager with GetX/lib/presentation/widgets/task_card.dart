import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';
import 'package:taskmanager/presentation/controllers/deleted_task_card_controller.dart';

class TaskCard extends StatefulWidget {
  const TaskCard({
    super.key,
    required this.taskItem,
    required this.refreshList,
  });

  final TaskItem taskItem;
  final VoidCallback refreshList;

  @override
  State<TaskCard> createState() => _TaskCardState();
}

class _TaskCardState extends State<TaskCard> {
  final UpdateController _updateController = Get.find<UpdateController>();
  final DeletedController _deletedController = Get.find<DeletedController>();
  bool _updateTaskInProgress = false;
  bool _deleteTaskInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColor.whiteColor,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.taskItem.title ?? '',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(widget.taskItem.description ?? ''),
            Text("Date: ${widget.taskItem.createdDate}"),
            Row(
              children: [
                // const Chip(label: Text('New')),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: getStatusColor(widget.taskItem.status ?? '')),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                    child: Text(
                      widget.taskItem.status ?? '',
                      style: const TextStyle(color: AppColor.whiteColor),
                    ),
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: _updateTaskInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                      onPressed: () {
                        _showUpdateStatusDialog(widget.taskItem.sId!);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: AppColor.themeColor,
                      )),
                ),
                Visibility(
                  visible: _deleteTaskInProgress == false,
                  replacement: const CircularProgressIndicator(),
                  child: IconButton(
                      onPressed: () {
                        _deleteTaskById(widget.taskItem.sId!);
                      },
                      icon: const Icon(
                        Icons.delete_outline,
                        color: AppColor.redAccentColor,
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'New':
        return AppColor.lightBlueColor;
      case 'Progress':
        return AppColor.purpleColor;
      case 'Cancelled':
        return AppColor.redAccentColor;
      case 'Completed':
        return AppColor.themeColor;
      default:
        return AppColor.transparentColor;
    }
  }

  bool _isCurrentStatus(String status) {
    return widget.taskItem.status! == status;
  }

  void _showUpdateStatusDialog(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Select status'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('New'),
                trailing:
                    _isCurrentStatus('New') ? const Icon(Icons.check) : null,
                onTap: () {
                  if (_isCurrentStatus('New')) {
                    return;
                  }
                  _updateTaskById(id, 'New');
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('Completed'),
                trailing: _isCurrentStatus('Completed')
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  if (_isCurrentStatus('Completed')) {
                    return;
                  }
                  _updateTaskById(id, 'Completed');
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('Progress'),
                trailing: _isCurrentStatus('Progress')
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  if (_isCurrentStatus('Progress')) {
                    return;
                  }
                  _updateTaskById(id, 'Progress');
                  Get.back();
                },
              ),
              ListTile(
                title: const Text('Cancelled'),
                trailing: _isCurrentStatus('Cancelled')
                    ? const Icon(Icons.check)
                    : null,
                onTap: () {
                  if (_isCurrentStatus('Cancelled')) {
                    return;
                  }
                  _updateTaskById(id, 'Cancelled');
                  Get.back();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _updateTaskById(String id, String status) async {
    _updateTaskInProgress = true;
    setState(() {});
    final result = await _updateController.updateTaskById(id, status);
    _updateTaskInProgress = false;
    setState(() {});
    if (result) {
      widget.refreshList();
    } else {
      if (mounted) {
        showSnackBar(
          context,
          _updateController.errorMessage,
        );
      }
    }
  }

  Future<void> _deleteTaskById(String id) async {
    _deleteTaskInProgress = true;
    setState(() {});
    final result = await _deletedController.deleteTaskById(id);
    _deleteTaskInProgress = false;
    setState(() {});
    if (result) {
      widget.refreshList();
    } else {
      setState(() {});
      if (mounted) {
        showSnackBar(context, _deletedController.errorMessage);
      }
    }
  }
}
