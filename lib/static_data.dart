import 'package:nmt_apdp_assigment/oop/course_object.dart';
import 'package:nmt_apdp_assigment/oop/teacher_object.dart';

List<TeacherObject> teachers = [
  TeacherObject(
    id: 'T001',
    name: 'U Kyaw Min',
    contactInfo: ['kyawmin@gmail.com', '+95 9 777 123456'],
  ),
  TeacherObject(
    id: 'T002',
    name: 'Daw Aye Aye Win',
    contactInfo: ['ayeayewin@outlook.com', '+95 9 876 543210'],
  ),
  TeacherObject(
    id: 'T003',
    name: 'U Hla Myint',
    contactInfo: ['hlamyint@teacher.edu.mm', '+95 9 222 334455'],
  ),
  TeacherObject(
    id: 'T004',
    name: 'Daw Hnin Thandar',
    contactInfo: ['hninthandar@yahoo.com', '+95 9 888 998877'],
  ),
  TeacherObject(
    id: 'T005',
    name: 'U Than Tun',
    contactInfo: ['thantun@teacher.org', '+95 9 111 223344'],
  ),
];

List<CourseObject> courses = [
  CourseObject(
    id: 'C001',
    title: 'Web Development Basics',
    description: 'An introductory course to HTML, CSS, and JavaScript.',
    cost: 150.0,
    teacherName: 'U Kyaw Min',
    durationInWeek: 6.0,
  ),
  CourseObject(
    id: 'C002',
    title: 'Data Structures and Algorithms',
    description: 'Learning core algorithms and data structures for efficient programming.',
    cost: 200.0,
    teacherName: 'Daw Aye Aye Win',
    durationInWeek: 8.0,
  ),
  CourseObject(
    id: 'C003',
    title: 'Advanced Database Systems',
    description: 'Exploring database management and design in depth.',
    cost: 250.0,
    teacherName: 'U Hla Myint',
    durationInWeek: 10.0,
  ),
  CourseObject(
    id: 'C004',
    title: 'Mobile App Development',
    description: 'Learn to develop mobile apps using Flutter and Dart.',
    cost: 180.0,
    teacherName: 'Daw Hnin Thandar',
    durationInWeek: 7.0,
  ),
  CourseObject(
    id: 'C005',
    title: 'Machine Learning with Python',
    description: 'An introduction to machine learning and building models with Python.',
    cost: 300.0,
    teacherName: 'U Than Tun',
    durationInWeek: 12.0,
  ),
];
