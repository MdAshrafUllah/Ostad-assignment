import 'package:taskmanager/import_links.dart';

PreferredSizeWidget appBarStyle(bool isUpdateUserProfileScreen) {
  return AppBar(
    foregroundColor: AppColor.whiteColor,
    backgroundColor: AppColor.themeColor,
    automaticallyImplyLeading: false,
    title: GestureDetector(
      onTap: () {
        if (isUpdateUserProfileScreen == true) {
          Navigator.push(
            TaskManager.navigatorKey.currentState!.context,
            MaterialPageRoute(
              builder: (context) => const UpdateUserProfileScreen(),
            ),
          );
        }
      },
      child: Row(
        children: [
          buildAvatar(),
          // CircleAvatar(
          //   // backgroundImage:
          //   //     MemoryImage(base64Decode(AuthController.userData!.photo!)),
          //   backgroundColor: Colors.amber,
          // ),
          const SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AuthController.userData?.fullName ?? '',
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              Text(
                AuthController.userData?.email ?? '',
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    ),
    actions: [
      IconButton(
          onPressed: () {
            AuthController.removeUserData();
            Navigator.pushAndRemoveUntil(
                TaskManager.navigatorKey.currentState!.context,
                MaterialPageRoute(builder: (context) => const SignInScreen()),
                (route) => false);
          },
          icon: const Icon(Icons.logout_rounded))
    ],
  );
}

CircleAvatar buildAvatar() {
  try {
    String base64String = AuthController.userData!.photo!
        .replaceAll('data:image/png;base64,', '');
    Uint8List bytes = base64Decode(base64String);
    return CircleAvatar(
      backgroundImage: MemoryImage(bytes),
      backgroundColor: Colors.amber,
    );
  } catch (e) {
    log('Error: $e');
    return const CircleAvatar(
      backgroundColor: Colors.amber,
      child: Icon(Icons.error),
    );
  }
}
