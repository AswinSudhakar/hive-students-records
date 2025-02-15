//name

//age

//Subject

//address

// import 'package:hive/hive.dart';

import 'package:hive_flutter/hive_flutter.dart';

part 'student_models.g.dart';

@HiveType(typeId: 0)
class Student {
  @HiveField(0)
  late String? name;

  @HiveField(1)
  late int? age;

  @HiveField(2)
  late String? subject;

  @HiveField(3)
  late String? address;

  Student({
    required this.name,
    required this.age,
    required this.subject,
    required this.address,
  });
}
