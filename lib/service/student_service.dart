import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_student_record/models/student_models.dart';

class StudentService {
  //create instance of the box
  Box<Student>? _studentBox;

  //openBox
  Future<void> openBox() async {
    _studentBox = await Hive.openBox<Student>('Students');
  }

  //Close Box
  Future<void> closeBox() async {
    await _studentBox!.close();
  }

  //add Student

  Future<void> addStudent(Student student) async {
    if (_studentBox == null) {
      await openBox();
    }
    await _studentBox!.add(student);
  }

  //get all students
  Future<List<Student>> getStudent() async {
    if (_studentBox == null) {
      await openBox();
    }
    return _studentBox!.values.toList();
  }

  //update

  Future<void> updteStudent(int index, Student student) async {
    if (_studentBox == null) {
      await openBox();
    }
    await _studentBox!.putAt(index, student);
  }

  //delete
  Future<void> deleteStudent(int index) async {
    if (_studentBox == null) {
      await openBox();
    }
    await _studentBox!.deleteAt(index);
  }
}
