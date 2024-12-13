import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Save the registration data
  Future<void> saveRegistrationData({
    required String nationalId,
    required String farmId,
    required String fatherName,
    required String coopName,
    required String coopId,
    required String dob,
    required String gender,
    required String
        photoUrl, // Assume this URL is passed after uploading the photo
  }) async {
    try {
      // Create a document with a custom ID (e.g., using the current date)
      final docRef =
          _db.collection('registrations').doc(DateTime.now().toString());

      // Save the data
      await docRef.set({
        'nationalId': nationalId,
        'farmId': farmId,
        'fatherName': fatherName,
        'coopName': coopName,
        'coopId': coopId,
        'dob': dob,
        'gender': gender,
        'photoUrl': photoUrl, // Storing the URL of uploaded photo
        'createdAt': FieldValue.serverTimestamp(),
      });

      print("Data saved successfully!");
    } catch (e) {
      print("Error saving data: $e");
    }
  }
}
