import 'role.dart';

class Person implements Role {
  late String name;
  late int age;
  late String address;

  Person(this.name, this.age, this.address);

  @override
  void displayRole() {}
}