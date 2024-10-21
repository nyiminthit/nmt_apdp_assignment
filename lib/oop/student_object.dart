import 'package:nmt_apdp_assigment/oop/person_abstract.dart';
import 'package:nmt_apdp_assigment/oop/record_object.dart';

class StudentObject implements PersonAbstract {
  @override
  String _id;
  @override
  String name;
  Map<String, String> contactInfo;
  String section;
  List<RecordObject> records;
  double discountPercent;

  StudentObject(
      {required String id,
      required this.name,
      required this.contactInfo,
      required this.section,
      required this.records,
      this.discountPercent = 0.0})
      : _id = id;

  String get studentId => _id;

  Map<String, dynamic> toFirebaseMap() {
    return {
      "id": _id,
      "name": name,
      "contactInfo": contactInfo,
      "section": section,
      "records": records.map((record) => record.toFirebaseMap()).toList()
    };
  }

  static StudentObject fromFirebaseMap(Map<String, dynamic> map) {
    // Change here: contactInfo is now expected as a Map<String, String>
    Map<String, String> contactInfo =
        Map<String, String>.from(map['contactInfo']);

    List<RecordObject> records = (map['records'] as List<dynamic>)
        .map((recordMap) => RecordObject.fromFirebaseMap(recordMap))
        .toList();

    return StudentObject(
        id: map['id'],
        name: map['name'],
        contactInfo: contactInfo,
        section: map['section'],
        records: records);
  }

  static factoryMethod(StudentObject student) {
    int numberOfCourseAttended = student.records.length;
    if (numberOfCourseAttended >= 3) {
      return Level3Student(
          id: student._id,
          name: student.name,
          contactInfo: student.contactInfo,
          section: student.section,
          records: student.records);
    } else if (numberOfCourseAttended == 2) {
      return Level2Student(
          id: student._id,
          name: student.name,
          contactInfo: student.contactInfo,
          section: student.section,
          records: student.records);
    } else if (numberOfCourseAttended == 1) {
      return Level1Student(
          id: student._id,
          name: student.name,
          contactInfo: student.contactInfo,
          section: student.section,
          records: student.records);
    } else {
      return student;
    }
  }
}

class Level1Student extends StudentObject {
  Level1Student(
      {required super.id,
      required super.name,
      required super.contactInfo,
      required super.section,
      required super.records,
      super.discountPercent = 5.0});
}

class Level2Student extends StudentObject {
  Level2Student(
      {required super.id,
      required super.name,
      required super.contactInfo,
      required super.section,
      required super.records,
      super.discountPercent = 10.0});
}

class Level3Student extends StudentObject {
  Level3Student(
      {required super.id,
      required super.name,
      required super.contactInfo,
      required super.section,
      required super.records,
      super.discountPercent = 20.0});
}
