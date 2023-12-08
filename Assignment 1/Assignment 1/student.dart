import 'person.dart';

class Student extends Person {
  late List<int> courseScores;

  Student(String name, int age, String address,this.courseScores)
      : super(name, age, address);

  @override
  void displayRole() {
    print("Role: Student");
  }

  double calculateAverageScore() {
    var total = 0;
    for (var score in courseScores) {
      total += score;
    }
    return total / courseScores.length;
  }
}