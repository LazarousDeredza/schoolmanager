import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String name;
  String uid;
  String email;
  String phoneNumber;
  String address;

  final String? id;
  final String firstName;
  final String lastName;
  final String password;
  final String? level;
  final String? image;
  final List? groups;
  final String? createdAt;
  final List instGroups;
  final String about;
  final bool isOnline;
  final String lastActive;
  final String pushToken;

  UserModel({
    required this.name,
    required this.uid,
    required this.email,
    required this.phoneNumber,
    required this.address,


    this.id,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.instGroups,
    this.level,
    this.groups,
    this.image,
    this.createdAt,
    required this.about,
    required this.isOnline,
    required this.lastActive,
    required this.pushToken,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'uid': uid,
        'email': email,
        'phone_number': phoneNumber,
        'address': address,

        
        'id': id,
        'firstName': firstName,
        'lastName': lastName,
        'password': password,
        'level': level,
        'groups': groups,
        'instGroups': instGroups,
        'image': image,
        'created_at': createdAt,
        'about': about,
        'is_online': isOnline,
        'last_active': lastActive,
        'push_token': pushToken,
      };

  static UserModel fromJson(DocumentSnapshot snapshot) {
    var snap = snapshot.data() as Map<String, dynamic>;
    return UserModel(
      name: snap['name'],
      uid: snap['uid'],
      email: snap['email'],
      phoneNumber: snap['phone_number'],
      address: snap['address'],



      id: snapshot.id,
      firstName: snap!['firstName'],
      lastName: snap['lastName'],
      password: snap['password'],
      level: snap['level'],
      groups: snap['groups'],
      instGroups: snap['instGroups'],
      image: snap['image'],
      createdAt: snap['created_at'],
      about: snap['about'] ?? '',
      isOnline: snap['is_online'],
      lastActive: snap['last_active'],
      pushToken: snap['push_token'],
    );
  }
}
