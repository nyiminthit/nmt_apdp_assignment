import 'package:flutter/material.dart';
import 'package:nmt_apdp_assigment/logout_bottom.dart';
import 'package:nmt_apdp_assigment/oop/object_methods/student_object_methods.dart';
import 'package:nmt_apdp_assigment/oop/student_object.dart';
import 'package:nmt_apdp_assigment/static_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<StudentObject>? students;
  int totalTeachers = teachers.length;
  int totalCourses = courses.length;
  int totalStudents = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    StudentObjectMethods studentObjectMethods = StudentObjectMethods();
    students = await studentObjectMethods.getAllStudents();
    setState(() {
      totalStudents = students?.length ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        backgroundColor: Colors.deepPurple,
        actions: [LogoutBottom()],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Overview',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // Display 2 cards per row
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildInfoCard(
                    context,
                    'Students',
                    totalStudents.toString(),
                    Icons.school,
                    Colors.blue,
                  ),
                  _buildInfoCard(
                    context,
                    'Teachers',
                    totalTeachers.toString(),
                    Icons.person,
                    Colors.orange,
                  ),
                  _buildInfoCard(
                    context,
                    'Courses',
                    totalCourses.toString(),
                    Icons.book,
                    Colors.green,
                  ),
                  // You can add more cards here if needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Custom card widget for each stat
  Widget _buildInfoCard(BuildContext context, String title, String count, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, size: 40, color: color),
            ),
            const SizedBox(height: 10),
            Text(
              count,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
