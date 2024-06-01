class Student {
  final String id;
  final String name;
  final String dob;
  final int grade, feesPaid;
  final String className;
  final String email;
  final String phoneNumber;
  final String address;
  final String parentName;
  final String parentPhoneNumber;
  final String date_time;

  Student({
   required this.id,
    required this.name,
    required this.dob,
    required this.grade,
    required this.feesPaid,
    required this.className,
    required this.email,
    required this.phoneNumber,
    required this.address,
    required this.parentName,
    required this.parentPhoneNumber,
    required this.date_time,
  });

  // Convert a Map to a Student object
  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'],
      name: map['name'],
      dob: map['dob'],
      feesPaid: map['feesPaid'],
      grade: map['grade'],
      className: map['class'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      address: map['address'],
      parentName: map['parentName'],
      date_time: map['date_time'],
      parentPhoneNumber: map['parentPhoneNumber'],
    );
  }

  // Convert a Student object to a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'dob': dob,
      'grade': grade,
      'email': email,
      'class': className,
      'feesPaid': feesPaid,
      'phoneNumber': phoneNumber,
      'address': address,
      'parentName': parentName,
      'date_time':date_time,
      'parentPhoneNumber': parentPhoneNumber,
    };
  }
}
