import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nmt_apdp_assigment/oop/student_object.dart';

class StudentObjectMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final String collectionPath =
      'students'; // Path to the students collection in Firestore

  // Add a student to Firestore
  Future<void> addStudent(StudentObject student) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(student.studentId)
          .set(student.toFirebaseMap());
    } catch (e) {
      print('Error adding student: $e');
      rethrow;
    }
  }

  // Get a student from Firestore by ID
  Future<StudentObject?> getStudentById(String id) async {
    try {
      DocumentSnapshot<Map<String, dynamic>> doc =
          await _firestore.collection(collectionPath).doc(id).get();
      if (doc.exists) {
        return StudentObject.fromFirebaseMap(doc.data()!);
      }
    } catch (e) {
      print('Error fetching student by ID: $e');
      rethrow;
    }
    return null; // Return null if the student is not found
  }

  // Update a student's data in Firestore
  Future<void> updateStudent(StudentObject student) async {
    try {
      await _firestore
          .collection(collectionPath)
          .doc(student.studentId)
          .update(student.toFirebaseMap());
    } catch (e) {
      print('Error updating student: $e');
      rethrow;
    }
  }

  // Delete a student from Firestore
  Future<void> deleteStudent(String id) async {
    try {
      await _firestore.collection(collectionPath).doc(id).delete();
    } catch (e) {
      print('Error deleting student: $e');
      rethrow;
    }
  }

  // Get all students from Firestore
  Future<List<StudentObject>> getAllStudents() async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await _firestore.collection(collectionPath).get();
      return querySnapshot.docs
          .map((doc) => StudentObject.fromFirebaseMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching all students: $e');
      rethrow;
    }
  }

  // Example method to get students filtered by section
  Future<List<StudentObject>> getStudentsBySection(String section) async {
    try {
      QuerySnapshot<Map<String, dynamic>> querySnapshot = await _firestore
          .collection(collectionPath)
          .where('section', isEqualTo: section)
          .get();

      return querySnapshot.docs
          .map((doc) => StudentObject.fromFirebaseMap(doc.data()))
          .toList();
    } catch (e) {
      print('Error fetching students by section: $e');
      rethrow;
    }
  }
}
