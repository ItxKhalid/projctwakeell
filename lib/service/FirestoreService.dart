import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference _clientsCollection =
  FirebaseFirestore.instance.collection('client');
  final CollectionReference _lawyersCollection =
  FirebaseFirestore.instance.collection('lawyer');

  Future<void> addClient({
    required String firstName,
    required String lastName,
    required String email,
    required String cnic,
    required String phoneNumber,
    required String gender,
  }) async {
    try {
      await _clientsCollection.add({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'cnic': cnic,
        'phoneNumber': phoneNumber,
        'gender': gender,
      });
    } catch (e) {
      print('Error adding client: $e');
      throw e;
    }
  }

  Future<void> addLawyer({
    required String firstName,
    required String lastName,
    required String email,
    required String cnic,
    required String phoneNumber,
    required String gender,
  }) async {
    try {
      await _lawyersCollection.add({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'cnic': cnic,
        'phoneNumber': phoneNumber,
        'gender': gender,
      });
    } catch (e) {
      print('Error adding lawyer: $e');
      throw e;
    }
  }
}
