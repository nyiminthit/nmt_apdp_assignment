class RecordObject {
  final String _id;
  DateTime enrollmentDate;
  String section;
  String courseId;
  String courseName;
  double finalCost;
  double discount;

  RecordObject(
      {required String id,
      required this.enrollmentDate,
      required this.section,
      required this.courseId,
      required this.courseName,
      required this.finalCost,
      required this.discount})
      : _id = id;

  Map<String, dynamic> toFirebaseMap() {
    return {
      'id': _id,
      'enrollmentDate': enrollmentDate,
      'section': section,
      'courseId': courseId,
      'courseName': courseName,
      'finalCost': finalCost,
      'discount': discount
    };
  }

  static RecordObject fromFirebaseMap(Map<String, dynamic> map) {
    return RecordObject(
        id: map['id'],
        enrollmentDate: map['enrollmentDate'],
        section: map['section'],
        courseId: map['courseId'],
        courseName: map['courseName'],
        finalCost: map['finalCost'],
        discount: map['discount']);
  }
}
