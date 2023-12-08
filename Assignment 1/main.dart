import 'student.dart';
import 'teacher.dart';

void main() {
  // Create instances of Student and Teacher classes
  var studentScores = [90, 85, 82];
  Student student = Student("John Doe", 20, "123 Main St", studentScores);

  var teacherCourses = ["Math", "English", "Bangla"];
  Teacher teacher = Teacher("Mrs. Smith", 35, "456 Oak St", teacherCourses);

  // Display information using displayRole() method
  student.displayRole();
  print("Name: ${student.name}");
  print("Age: ${student.age}");
  print("Address: ${student.address}");
  print("Average Score: ${student.calculateAverageScore().toStringAsFixed(2)}\n");

  teacher.displayRole();
  print("Name: ${teacher.name}");
  print("Age: $teacher.age}");
  print("Address: ${teacher.address}");
  teacher.displayCoursesTaught();
}