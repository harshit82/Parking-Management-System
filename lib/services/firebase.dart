import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vehicle_parking_management/models/vehicle.dart';

class CRUD {
  /// @func to add a new user to the database
  Future<String> addDocument(
      {required Map<String, dynamic> dataToBeAdded,
      required String vehicleNumber}) async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');

    return collectionReference
        .doc(vehicleNumber)
        .set(dataToBeAdded)
        .then((value) => "Successfully added")
        .catchError((error) => "Failed to add user: $error");
  }

  /// @func to update the data of an existing user in the database
  Future<String> updateData(
      {required String vehicleNumber,
      required String field,
      required var data}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection('users').doc(vehicleNumber);

    Map<String, dynamic> updatedDataMap = <String, dynamic>{field: data};

    return documentReference
        .update(updatedDataMap)
        .then((value) => "Successfully Updated")
        .catchError((error) => "Failed to update data: $error");
  }

  Future<Vehicle?> getDocument({required String documentId}) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection('users').doc(documentId);

    final snapshot = await documentReference.get();

    if (snapshot.exists) {
      return Vehicle.fromJson(snapshot.data()!);
    }
    return null;
  }
}
