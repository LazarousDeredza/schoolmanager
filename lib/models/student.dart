class Student {
  final int id;
  final String name;
  final int age;
  final String grade;
  final String email;
  final String phoneNumber;
  final String address;
  final String parentName;
  final String parentEmail;
  final String parentPhoneNumber;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.grade,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.parentName,
    required this.parentEmail,
    required this.parentPhoneNumber,
  });

  // Convert a Map to a Student object
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      age: map['age'],
      grade: map['grade'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      parentName: map['parentName'],
      parentEmail: map['parentEmail'],
      parentPhoneNumber: map['parentPhoneNumber'],
    );
  }

  // Convert a Student object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'grade': grade,
      'email': email,
      'phoneNumber': phoneNumber,
      'address': address,
      'parentName': parentName,
      'parentEmail': parentEmail,
      'parentPhoneNumber': parentPhoneNumber,
    };
  }
}