import 'package:flutter/material.dart';
import 'package:nmt_apdp_assigment/oop/course_object.dart';
import 'package:nmt_apdp_assigment/oop/object_methods/student_object_methods.dart';
import 'package:nmt_apdp_assigment/oop/student_object.dart';
import 'package:nmt_apdp_assigment/static_data.dart';
import 'package:uuid/uuid.dart';

class StudentRegisterPage extends StatefulWidget {
  const StudentRegisterPage({super.key});

  @override
  State<StudentRegisterPage> createState() => _StudentRegisterPageState();
}

class _StudentRegisterPageState extends State<StudentRegisterPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Dropdown value for section
  String? _selectedSection;
  final List<String> sections = ['Morning', 'Afternoon', 'Evening'];

  // Keep track of selected courses
  final List<CourseObject> selectedCourses = [];
  final List<String> selectedCoursesIds = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Student Registration'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Student Name Input
                _buildCustomTextField(
                  controller: _nameController,
                  label: 'Name',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter the student name';
                    }
                    return null;
                  },
                ),

                // Phone Input
                _buildCustomTextField(
                  controller: _phoneController,
                  label: 'Phone',
                  icon: Icons.phone,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                ),

                // Email Input
                _buildCustomTextField(
                  controller: _emailController,
                  label: 'Email',
                  icon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter email address';
                    }
                    return null;
                  },
                ),

                // Section Dropdown
                _buildDropdown(),

                const SizedBox(height: 20),

                // Register Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _registerStudent();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Register Student'),
                ),

                const SizedBox(height: 20),

                // Display Courses
                _buildCoursesSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Build Custom Input Field Widget
  Widget _buildCustomTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
        validator: validator,
      ),
    );
  }

  // Build Dropdown for Section
  Widget _buildDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _selectedSection,
        decoration: InputDecoration(
          labelText: 'Section',
          prefixIcon: const Icon(Icons.class_),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.deepPurple, width: 2),
          ),
        ),
        items: sections.map((section) {
          return DropdownMenuItem<String>(
            value: section,
            child: Text(section),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            _selectedSection = value;
          });
        },
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a section';
          }
          return null;
        },
      ),
    );
  }

  // Display selectable courses
  Widget _buildCoursesSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Select Courses',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 10),
          if (courses.isEmpty)
            const Text('No courses available.',
                style: TextStyle(color: Colors.grey))
          else
            ...courses.map((course) {
              return CheckboxListTile(
                title: Text(course.title),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(course.description),
                    Text('Cost: \$${course.cost.toStringAsFixed(2)}'),
                    Text('Teacher: ${course.teacherName}'),
                    Text('Duration: ${course.durationInWeek} weeks'),
                  ],
                ),
                value: selectedCoursesIds.contains(course.courseId),
                onChanged: (bool? value) {
                  setState(() {
                    if (value == true) {
                      selectedCourses.add(course);
                      selectedCoursesIds.add(course.courseId);
                    } else {
                      selectedCourses.remove(course);
                      selectedCoursesIds.remove(course.courseId);
                    }
                  });
                },
              );
            }).toList(),
        ],
      ),
    );
  }

  // Handle Student Registration
  void _registerStudent() {
    if (_formKey.currentState?.validate() ?? false) {
      if (selectedCourses.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one course')),
        );
        return;
      }
      var id = const Uuid().v1();
      Map<String, String> contactInfo = {
        "phone": _phoneController.text,
        "email": _emailController.text
      };
      StudentObject newStudent = StudentObject(
          id: id,
          name: _nameController.text,
          contactInfo: contactInfo,
          section: _selectedSection!,
          records: []);

      StudentObjectMethods studentObjectMethods = StudentObjectMethods();
      studentObjectMethods.addStudent(newStudent);

      studentObjectMethods.addCourses(newStudent, selectedCourses);
    }
    setState(() {
      _nameController.text = '';
      _phoneController.text = '';
      _emailController.text = '';
      _selectedSection = null;
      selectedCourses.clear();
      selectedCoursesIds.clear();
    });

    // Registration logic here
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Student Registered Successfully with courses: ${selectedCourses.join(', ')}'),
      ),
    );
  }
}
