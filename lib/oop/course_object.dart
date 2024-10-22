class CourseObject {
  final String _id;
  String title;
  String description;
  double cost;
  String teacherName;
  double durationInWeek;

  // Constructor
  CourseObject({
    required String id,
    required this.title,
    required this.description,
    required this.cost,
    required this.teacherName,
    required this.durationInWeek,
  }) : _id = id;

  String get courseId => _id;

  // Method to convert the object to a Firebase Map
  Map<String, dynamic> toFirebaseMap() {
    return {
      'id': _id,
      'title': title,
      'description': description,
      'cost': cost,
      'teacherName': teacherName,
      'durationInWeek': durationInWeek,
    };
  }

  // Static method to create a CourseObject from Firebase Map
  static CourseObject fromFirebaseMap(Map<String, dynamic> map) {
    return CourseObject(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      cost: map['cost'],
      teacherName: map['teacherName'],
      durationInWeek: map['durationInWeek'],
    );
  }
}
