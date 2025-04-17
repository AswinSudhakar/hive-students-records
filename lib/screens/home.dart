import 'package:flutter/material.dart';
import 'package:hive_student_record/models/student_models.dart';
import 'package:hive_student_record/screens/student.dart';
import 'package:hive_student_record/service/student_service.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final TextEditingController _namecntroler = TextEditingController();
  final TextEditingController _agecntroler = TextEditingController();
  final TextEditingController _subjectcntroler = TextEditingController();
  final TextEditingController _addresscntroler = TextEditingController();

  final FocusNode _focusnode1 = FocusNode();
  final FocusNode _focusnode2 = FocusNode();
  final FocusNode _focusnode3 = FocusNode();
  final FocusNode _focusnode4 = FocusNode();

  final StudentService _studentService = StudentService();
  List<Student> _students = [];

  //function to show all listbfrom db

  Future<void> _loadStudent() async {
    _students = await _studentService.getStudent();
    setState(() {});
  }

  @override
  void initState() {
    _loadStudent();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: Colors.amber,
        //   onPressed: () {
        //     _showAddStud();
        //   },
        //   child: Icon(Icons.add),
        // ),

        floatingActionButton: FloatingActionButton(
          shape: CircleBorder(),
          onPressed: () {
            _showAddStud();
          },
          child: Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          color: Colors.amber, // Set the amber background color
          shape:
              CircularNotchedRectangle(), // Notch for the floating action button
          child: SizedBox(height: 60), // Height of the BottomAppBar
        ),

        appBar: AppBar(
          toolbarHeight: 90,
          backgroundColor: Colors.amber,
          centerTitle: true,
          title: Text(
            'Student Record',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ),

        body: _students.isEmpty
            ? Center(
                child: Text(
                  'No Students Found',
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic),
                ),
              )
            : SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: ListView.builder(
                  padding: EdgeInsets.all(15),
                  itemCount: _students.length,
                  itemBuilder: (context, index) {
                    final student = _students[index];
                    return Card(
                      elevation: 15,
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text((index + 1).toString()),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      StudentPage(model: student)));
                        },
                        title: Text("${student.name}"),
                        subtitle: Text("${student.subject}"),
                        trailing: Wrap(
                          spacing: 10,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _showupdatedStud(
                                    index,
                                    student,
                                  );

                                  //update option
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  _studentService.deleteStudent(index);

                                  _loadStudent();
                                  //delete
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
      ),
    );
  }

  Future<void> _showAddStud() async {
    //show dialogue shows material dialogue over the current content of the screen
    await showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text('Add New Student'),
              content: SizedBox(
                height: 330,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    //four fields for student
                    TextField(
                      focusNode: _focusnode1, // maxLength: 15,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "Name"),
                      controller: _namecntroler,
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focusnode2);
                      },
                    ),
                    TextField(
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focusnode3);
                      },
                      focusNode: _focusnode2,

                      // maxLength: 2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Age'),
                      controller: _agecntroler,
                    ),
                    TextField(
                      focusNode: _focusnode3,
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focusnode4);
                      },
                      // maxLength: 15,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'subject'),
                      controller: _subjectcntroler,
                    ),
                    TextField(
                      focusNode: _focusnode4,
                      style: TextStyle(),
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          hintText: 'Address'),
                      controller: _addresscntroler,
                    ),
                  ],
                ),
              ),

              //Two buttons for add and cancel
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    final name = _namecntroler.text;
                    final age = _agecntroler.text;
                    final subject = _subjectcntroler.text;
                    final address = _addresscntroler.text;

                    if (name.isEmpty ||
                        age.isEmpty ||
                        subject.isEmpty ||
                        address.isEmpty) {
                      return;
                    }
                    {
                      final newStudent = Student(
                          name: _namecntroler.text,
                          age: int.parse(_agecntroler.text),
                          subject: _subjectcntroler.text,
                          address: _addresscntroler.text);

                      await _studentService.addStudent(newStudent);

                      _namecntroler.clear();
                      _agecntroler.clear();
                      _addresscntroler.clear();
                      _subjectcntroler.clear();

                      Navigator.pop(context);
                      _loadStudent();
                    }
                  },
                  child: Text('ADD'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('CANCEL'),
                )
              ],
            ),
          );
        });
  }

  Future<void> _showupdatedStud(
    int index,
    Student student,
  ) async {
    _namecntroler.text = student.name.toString();
    _agecntroler.text = student.age.toString();
    _subjectcntroler.text = student.subject.toString();
    _addresscntroler.text = student.address.toString();
    //show dialogue shows material dialogue over the current content of the screen
    await showDialog(
        context: context,
        builder: (context) {
          return SingleChildScrollView(
            child: AlertDialog(
              title: Text('Edit  Student'),
              content: SizedBox(
                height: 340,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  spacing: 10,
                  children: [
                    //four fields for student
                    TextField(
                      focusNode: _focusnode1,
                      // maxLength: 15,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: "Name"),
                      controller: _namecntroler,
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focusnode2);
                      },
                    ),
                    TextField(
                      focusNode: _focusnode2,
                      controller: _agecntroler,
                      // maxLength: 2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Age'),
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focusnode3);
                      },
                    ),
                    TextField(
                      focusNode: _focusnode3,
                      //

                      decoration: InputDecoration(
                          border: OutlineInputBorder(), hintText: 'Course'),
                      controller: _subjectcntroler,
                      onSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_focusnode4);
                      },
                    ),
                    TextField(
                      focusNode: _focusnode4,
                      style: TextStyle(),
                      decoration: InputDecoration(
                          // contentPadding: EdgeInsets.symmetric(
                          //     vertical: 10.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                          hintText: 'Address'),
                      controller: _addresscntroler,
                    ),
                  ],
                ),
              ),

              //Two buttons for add and cancel
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    student.name = _namecntroler.text;
                    student.age = int.parse(_agecntroler.text);
                    student.subject = _subjectcntroler.text;
                    student.address = _addresscntroler.text;

                    await _studentService.updteStudent(index, student);
                    _namecntroler.clear();
                    _agecntroler.clear();
                    _addresscntroler.clear();
                    _subjectcntroler.clear();

                    Navigator.pop(context);
                    _loadStudent();
                  },
                  child: Text('UPDATE'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('CANCEL'),
                )
              ],
            ),
          );
        });
  }
}
