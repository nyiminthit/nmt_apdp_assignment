import 'package:flutter/material.dart';
import 'package:nmt_apdp_assigment/logout_bottom.dart';
import 'package:nmt_apdp_assigment/oop/course_object.dart';
import 'package:nmt_apdp_assigment/oop/object_methods/student_object_methods.dart';
import 'package:nmt_apdp_assigment/oop/record_object.dart';
import 'package:nmt_apdp_assigment/oop/student_object.dart';
import 'package:nmt_apdp_assigment/static_data.dart';

class StudentEditPage extends StatefulWidget {
  final StudentObject student; // Pass the student to be edited
  const StudentEditPage({super.key, required this.student});

  @override
  State<StudentEditPage> createState() => _StudentEditPageState();
}

class _StudentEditPageState extends State<StudentEditPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;

  // Dropdown value for section
  String? _selectedSection;
  final List<String> sections = ['Morning', 'Afternoon', 'Evening'];

  // Keep track of selected courses
  List<CourseObject> selectedCourses = [];
  List<String> selectedCoursesIds = [];

  // Temporary list for unenrolled course selections
  List<String> tempSelectedCoursesIds = [];
  List<CourseObject> tempSelectedCourse = [];

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing student data
    _nameController = TextEditingController(text: widget.student.name);
    _phoneController =
        TextEditingController(text: widget.student.contactInfo['phone']);
    _emailController =
        TextEditingController(text: widget.student.contactInfo['email']);
    _selectedSection = widget.student.section;

    // Initialize selected courses based on student's current courses
    selectedCoursesIds =
        widget.student.records.map((record) => record.courseId).toList();

    // Initialize temporary list with current selections
    tempSelectedCoursesIds = List.from(selectedCoursesIds);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: const Text('Edit Student'),
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        actions: [
          LogoutBottom()
        ],
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

                // Save Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      _saveStudent();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                  ),
                  child: const Text('Save Changes'),
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
  // Display student records instead of just enrolled courses
  Widget _buildCoursesSection() {
    // Get the student's records
    List<RecordObject> studentRecords = widget.student.records;
    List<CourseObject> unenrolledCourses = courses
        .where((course) => !selectedCoursesIds.contains(course.courseId))
        .toList();
    return Column(
      children: [
        Container(
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
                'Enrollment Records',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),

              // Check if the student has any records
              if (studentRecords.isEmpty)
                const Text('No records available.',
                    style: TextStyle(color: Colors.grey))
              else
                // Display each record as a list tile
                ...studentRecords.map(
                  (record) {
                    return ListTile(
                      title: Text(record.courseName),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Section: ${record.section}'),
                          Text(
                              'Enrolled on: ${record.enrollmentDate.toString()}'),
                          Text(
                              'Final Cost: \$${record.finalCost.toStringAsFixed(2)}'),
                          Text('Discount: ${record.discount}%'),
                        ],
                      ),
                    );
                  },
                ).toList(),

              const Text(
                'Unenrolled Courses',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 10),
              if (unenrolledCourses.isEmpty)
                const Text('No unenrolled courses available.',
                    style: TextStyle(color: Colors.grey))
              else
                ...unenrolledCourses.map((course) {
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
                    value: tempSelectedCoursesIds.contains(course.courseId),
                    onChanged: (bool? value) {
                      setState(() {
                        if (value == true) {
                          tempSelectedCoursesIds.add(course.courseId);
                          tempSelectedCourse.add(course);
                        } else {
                          tempSelectedCoursesIds.remove(course.courseId);
                          tempSelectedCourse.remove(course);
                        }
                      });
                    },
                  );
                }).toList(),
            ],
          ),
        ),
      ],
    );
  }

  void _saveStudent() {
    // Update student info and save to database here
    StudentObject updatedStudent = StudentObject(
        id: widget.student.studentId,
        name: _nameController.text,
        contactInfo: {
          'phone': _phoneController.text,
          'email': _emailController.text,
        },
        section: _selectedSection!,
        records: widget.student.records);
    StudentObjectMethods studentObjectMethods = StudentObjectMethods();
    studentObjectMethods.updateStudent(updatedStudent).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Student details updated')),
      );
    });
    if (tempSelectedCourse.isNotEmpty) {
      studentObjectMethods
          .addCourses(updatedStudent, tempSelectedCourse)
          .then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Courses Enrolled!')),
        );
      });
    }
  }
}
