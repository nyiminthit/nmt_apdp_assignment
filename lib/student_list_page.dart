import 'package:flutter/material.dart';
import 'package:nmt_apdp_assigment/oop/object_methods/student_object_methods.dart';
import 'package:nmt_apdp_assigment/oop/student_object.dart';

class StudentListPage extends StatefulWidget {
  const StudentListPage({Key? key}) : super(key: key);

  @override
  State<StudentListPage> createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  List<StudentObject> students = [];

  @override
  void initState() {
    super.initState();
    _fetchStudents();
  }

  Future<void> _fetchStudents() async {
    StudentObjectMethods studentMethods = StudentObjectMethods();
    students = await studentMethods.getAllStudents(); // Implement this method
    setState(() {});
  }

  void _editStudent(StudentObject student) {
    // Implement edit logic here (e.g., navigate to edit page)
    // Navigator.push(...)
  }

  void _deleteStudent(String id) {
    setState(() {
      students.removeWhere((student) => student.studentId == id);
    });
    StudentObjectMethods studentObjectMethods = StudentObjectMethods();
    studentObjectMethods.deleteStudent(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Student deleted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: students.isEmpty
            ? const Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  final student = students[index];
                  return Card(
                    elevation: 4,
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16.0),
                      title: Text(student.name,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      subtitle: Text(
                          'Phone: ${student.contactInfo['phone']}\nEmail: ${student.contactInfo['email']}',
                          style: const TextStyle(color: Colors.grey)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.blue),
                            onPressed: () => _editStudent(student),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteStudent(student.studentId),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
