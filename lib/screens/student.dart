import 'package:flutter/material.dart';
import 'package:hive_student_record/models/student_models.dart';

class StudentPage extends StatelessWidget {
  Student model;

  StudentPage({super.key, required this.model});

  //function to show all listbfrom db

  // const StudentPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber, // Set the amber background color
        shape:
            CircularNotchedRectangle(), // Notch for the floating action button
        child: SizedBox(height: 60), // Height of the BottomAppBar
      ),
      appBar: AppBar(
        toolbarHeight: 90,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.backspace),
          // color: Colors.white,
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: Text(
          'Student Details',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 300,
            width: 300,
            decoration: BoxDecoration(color: Colors.amber),
            child: Column(
              spacing: 20,
              mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: NetworkImage(
                      "https://th.bing.com/th/id/OIP.ixZ69lPCOZ3ZO5UqSHQGIAHaHa?w=193&h=193&c=7&r=0&o=5&dpr=1.3&pid=1.7"),
                ),
                //four fields for student

                Text(
                  "NAME :${model.name!.toUpperCase()}",
                  style: TextStyle(fontSize: 20),
                ),
                Text("AGE :${model.age}", style: TextStyle(fontSize: 20)),
                Text("SUBJECT :${model.subject!.toUpperCase()}",
                    style: TextStyle(fontSize: 20)),
                Text("ADDRESS :${model.address!.toUpperCase()}",
                    style: TextStyle(fontSize: 20))
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
