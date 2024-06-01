import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolmanager/constant/constant.dart';

class FirestoreServices {
  //for get for you section data
  static getAllStudents() {
    return firestore
        .collection(allStudents)
        .get();
  }

  

  //for get top place section data
  static getStudentsbyGrade(int grade) {
    return firestore
        .collection(allStudents)
        .where('grade', isEqualTo: grade)
        .get();
  }

  //for get economy section data
  static getEconomyPackage() {
    return firestore
        .collection(allStudents)
        .where('economy', isEqualTo: true)
        .where('approved', isEqualTo: true)
        .get();
  }

  //for get luxury section data
  static getLuxuryPackage() {
    return firestore
        .collection(allStudents)
        .where('luxury', isEqualTo: true)
        .where('approved', isEqualTo: true)
        .get();
  }


  //for get login user uploaded packages
  static getUserUploadedPackages({required uid}) {
    return firestore
        .collection(allStudents)
        .where('approved', isEqualTo: true)
        .where('uid', isEqualTo: uid)
        .snapshots();
  }

  //for delete package:
  static deletePackage({required docId}) {
    return firestore.collection('all-data').doc(docId).delete();
  }

  //for tour guide package:
  static tourGuidePackage() {
    return firestore.collection('tour-guide').snapshots();
  }


  //for get top place section data
  static getStudentsByFees(int fees) {
    return firestore
        .collection(allStudents)
        .where('feesPaid', isGreaterThanOrEqualTo: fees)
        .get();
  }



  static getStudentsByFeesNotFull(int fees) {
    return firestore
        .collection(allStudents)
        .where('feesPaid', isLessThan: fees)
        .get();
  }

}
