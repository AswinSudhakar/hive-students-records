import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_student_record/models/student_models.dart';
import 'package:hive_student_record/screens/home.dart';
import 'package:hive_student_record/service/student_service.dart';

void main() async {
  //initialise hive
  await Hive.initFlutter();

  //register adaptor
  Hive.registerAdapter(StudentAdapter());

  //open a box

  await StudentService().openBox();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Homescreen(),
      ),
    );
  }
}
