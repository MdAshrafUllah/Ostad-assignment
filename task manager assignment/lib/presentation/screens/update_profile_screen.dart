import 'package:taskmanager/import_links.dart';

class UpdateUserProfileScreen extends StatefulWidget {
  const UpdateUserProfileScreen({super.key});

  @override
  State<UpdateUserProfileScreen> createState() =>
      _UpdateUserProfileScreenState();
}

class _UpdateUserProfileScreenState extends State<UpdateUserProfileScreen> {
  final TextEditingController _emailInputController = TextEditingController();
  final TextEditingController _fNameInputController = TextEditingController();
  final TextEditingController _lNameInputController = TextEditingController();
  final TextEditingController _mobileInputController = TextEditingController();
  final TextEditingController _passwordInputController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  XFile? _pickedImage;
  bool _updateProfileInProgress = false;

  @override
  void initState() {
    super.initState();
    _emailInputController.text = AuthController.userData?.email ?? '';
    _fNameInputController.text = AuthController.userData?.firstName ?? '';
    _lNameInputController.text = AuthController.userData?.lastName ?? '';
    _mobileInputController.text = AuthController.userData?.mobile ?? '';
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBarStyle(false),
      body: AppBackgroundWidget(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: size.height / 10,
                ),
                Text(
                  'Update Profile',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(
                  height: 16,
                ),
                imagePickerButton(),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  enabled: false,
                  controller: _emailInputController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _fNameInputController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _lNameInputController,
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _mobileInputController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    hintText: 'Mobile',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                TextFormField(
                  controller: _passwordInputController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: 'Password (Optional)',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Visibility(
                    visible: _updateProfileInProgress == false,
                    replacement: const Center(
                      child: CircularProgressIndicator(),
                    ),
                    child: ElevatedButton(
                        onPressed: () {
                          _updateProfile();
                        },
                        child: const Icon(Icons.arrow_circle_right_outlined)),
                  ),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  Widget imagePickerButton() {
    return GestureDetector(
      onTap: () {
        pickImageFromGallery();
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                  color: Colors.black54,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  )),
              child: const Text(
                'Photo',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                _pickedImage?.name ?? '',
                maxLines: 1,
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> pickImageFromGallery() async {
    ImagePicker imagePicker = ImagePicker();
    _pickedImage = await imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {});
  }

  Future<void> _updateProfile() async {
    String? photo;

    _updateProfileInProgress = true;
    setState(() {});

    Map<String, dynamic> inputParams = {
      "email": _emailInputController.text,
      "firstName": _fNameInputController.text.trim(),
      "lastName": _lNameInputController.text.trim(),
      "mobile": _mobileInputController.text.trim(),
    };

    if (_passwordInputController.text.isNotEmpty) {
      inputParams['password'] = _passwordInputController.text;
    }

    if (_pickedImage != null) {
      List<int> bytes = File(_pickedImage!.path).readAsBytesSync();
      photo = base64Encode(bytes);
      inputParams['photo'] = photo;
    } else {
      UserData? userData = await AuthController.getUserData();
      if (userData != null && userData.photo != null) {
        photo = userData.photo;
        inputParams['photo'] = photo;
      }
    }

    final response =
        await NetworkCaller.postRequest(Urls.profileUpdate, inputParams);
    _updateProfileInProgress = false;
    if (response.isSuccess) {
      if (response.responseBody['status'] == 'success') {
        UserData userData = UserData(
          email: _emailInputController.text,
          firstName: _fNameInputController.text.trim(),
          lastName: _lNameInputController.text.trim(),
          mobile: _mobileInputController.text.trim(),
          photo: photo,
        );
        await AuthController.saveUserData(userData);
      }
      if (mounted) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) => const MainBottomNavigation()),
            (route) => false);
      }
    } else {
      if (!mounted) {
        return;
      }
      setState(() {});
      showSnackBar(context, 'Update profile failed! Try again.', true);
    }
  }

  @override
  void dispose() {
    _emailInputController.dispose();
    _fNameInputController.dispose();
    _lNameInputController.dispose();
    _mobileInputController.dispose();
    _passwordInputController.dispose();
    super.dispose();
  }
}
