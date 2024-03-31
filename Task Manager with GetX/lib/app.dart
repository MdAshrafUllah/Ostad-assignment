import 'package:get/get.dart';
import 'package:taskmanager/import_links.dart';

class TaskManager extends StatefulWidget {
  const TaskManager({super.key});

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<TaskManager> createState() => _TaskManagerState();
}

class _TaskManagerState extends State<TaskManager> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: TaskManager.navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Task Manager',
      home: const SplashScreen(),
      theme: themeStyle(),
      initialBinding: ControllerBinder(),
    );
  }
}
