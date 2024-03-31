import 'package:taskmanager/import_links.dart';

class MainBottomNavigation extends StatefulWidget {
  const MainBottomNavigation({super.key});

  @override
  State<MainBottomNavigation> createState() => _MainBottomNavigationState();
}

class _MainBottomNavigationState extends State<MainBottomNavigation> {
  final List<Widget> _widgetOptions = <Widget>[
    const NewTaskScreen(),
    const CompleteTaskScreen(),
    const CancelledTaskScreen(),
    const ProgressTaskScreen(),
  ];
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedFontSize: 0,
        items: <BottomNavigationBarItem>[
          _buildBottomNavigationBarItem(
              Icons.file_copy_outlined, 'New Task', 0),
          _buildBottomNavigationBarItem(Icons.done_all_rounded, 'Completed', 1),
          _buildBottomNavigationBarItem(Icons.cancel_outlined, 'Canceled', 2),
          _buildBottomNavigationBarItem(Icons.cached_outlined, 'Progress', 3),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColor.whiteColor,
        unselectedItemColor: AppColor.greyColor,
        onTap: _onItemTapped,
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(
      IconData iconData, String text, int index) {
    final selected = index == _selectedIndex;
    return BottomNavigationBarItem(
      icon: _buildIcon(iconData, text, index, selected),
      label: text,
    );
  }

  Widget _buildIcon(IconData iconData, String text, int index, bool selected) {
    final bgColor = selected ? AppColor.themeColor : AppColor.whiteColor;
    final itemColor = selected ? AppColor.whiteColor : AppColor.greyColor;
    return SizedBox(
      width: double.infinity,
      height: kBottomNavigationBarHeight,
      child: Material(
        color: bgColor,
        child: InkWell(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(iconData),
              Text(text, style: TextStyle(fontSize: 12, color: itemColor)),
            ],
          ),
          onTap: () => _onItemTapped(index),
        ),
      ),
    );
  }
}
