import 'package:taskmanager/import_links.dart';

class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});
  @override
  State<AddNewTaskScreen> createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _subjectInputController = TextEditingController();
  final TextEditingController _descriptionInputController =
      TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isProgress = false;
  bool _shouldRefreshNewTaskList = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) {
          return;
        }
        Navigator.pop(context, _shouldRefreshNewTaskList);
      },
      child: Scaffold(
        appBar: appBarStyle(true),
        body: AppBackgroundWidget(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: size.height / 8,
                    ),
                    Text(
                      'Add New Task',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _subjectInputController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'Subject',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Subject';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _descriptionInputController,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: 8,
                      decoration: const InputDecoration(
                        hintText: 'Description',
                      ),
                      validator: (String? value) {
                        if (value?.trim().isEmpty ?? true) {
                          return 'Enter Description';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Visibility(
                        visible: _isProgress == false,
                        replacement: const Center(
                          child: CircularProgressIndicator(),
                        ),
                        child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                _addNewTask();
                              }
                            },
                            child:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addNewTask() async {
    _isProgress = true;
    setState(() {});

    Map<String, dynamic> inputParams = {
      "title": _subjectInputController.text,
      "description": _descriptionInputController.text,
      "status": "New"
    };

    final response =
        await NetworkCaller.postRequest(Urls.createTask, inputParams);

    _isProgress = false;
    setState(() {});

    if (response.isSuccess) {
      _shouldRefreshNewTaskList = true;
      _subjectInputController.clear();
      _descriptionInputController.clear();
      if (mounted) {
        showSnackBar(context, 'Add Task Successfully');
      }
    } else {
      if (mounted) {
        showSnackBar(
            context, response.errorMessage ?? 'Add New Task Failed', true);
      }
    }
  }

  @override
  void dispose() {
    _subjectInputController.dispose();
    _descriptionInputController.dispose();
    super.dispose();
  }
}
