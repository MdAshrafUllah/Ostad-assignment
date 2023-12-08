import 'person.dart';

class Teacher extends Person {
  late List<String> coursesTaught;

  Teacher(String name, int age, String address, this.coursesTaught)
      : super(name, age, address);

  @override
  void displayRole() {
    print("Role: Teacher");
  }

  void displayCoursesTaught() {
    print("Courses Taught:");
    for (var course in coursesTaught) {
      print("- $course");
    }
  }
}