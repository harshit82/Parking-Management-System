import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_parking_management/services/firebase.dart';
import 'package:vehicle_parking_management/utils/date_time_parsers.dart';

CRUD _crud = CRUD();

class VehicleController extends GetxController {
  /// {@controllers}
  final vehicleTypeController = TextEditingController();
  final driverNameController = TextEditingController();
  final ownerNameController = TextEditingController();
  final ownerContactNumberController = TextEditingController();
  final numberOfWheelsController = TextEditingController();
  final vehicleNumberController = TextEditingController();

  RxString vehicleNumberControllerText = ''.obs;
  RxString driverNameControllerText = ''.obs;
  RxString ownerNameControllerText = ''.obs;
  RxInt ownerContactNumberControllerText = 0.obs;
  RxInt numberOfWheelsControllerText = 0.obs;
  RxString vehicleTypeControllerText = ''.obs;

  @override
  void onInit() {
    vehicleNumberController.addListener(() {
      vehicleNumberControllerText.value = vehicleNumberController.text;
    });
    vehicleTypeController.addListener(() {
      vehicleTypeControllerText.value = vehicleTypeController.text;
    });
    driverNameController.addListener(() {
      driverNameControllerText.value = driverNameController.text;
    });
    vehicleNumberController.addListener(() {
      vehicleNumberControllerText.value = vehicleNumberController.text;
    });
    numberOfWheelsController.addListener(() {
      numberOfWheelsControllerText.value = numberOfWheelsController.text as int;
    });
    ownerContactNumberController.addListener(() {
      ownerContactNumberControllerText.value =
          ownerContactNumberController.text as int;
    });
    ownerNameController.addListener(() {
      ownerNameControllerText.value = ownerNameController.text;
    });
    super.onInit();
  }

  /// @func
  /// TODO: Not working
  fetchEntryDateAndTime() {
    try {
      Map<String, dynamic> snapshot =
          _crud.getDocument(documentId: vehicleNumberControllerText.toString())
              as Map<String, dynamic>;
      Timestamp timestamp = snapshot['Entry Date and Time'];
      debugPrint(timestamp.toString());
      DateTime dateTime = DateTime.parse(timestamp.toString());
      return dateTime;
    } catch (e) {
      return e;
    }
  }

  fetchExitDateAndTime() {
    try {
      Map<String, dynamic> snapshot =
          _crud.getDocument(documentId: vehicleNumberControllerText.toString())
              as Map<String, dynamic>;
      Timestamp timestamp = snapshot['Exit Date and Time'];
      debugPrint(timestamp.toString());
      DateTime dateTime = DateTime.parse(timestamp.toString());
      return dateTime;
    } catch (e) {
      return e;
    }
  }

  Future fetchEntryDate() async {
    try {
      return timestampDateParser(await fetchEntryDateAndTime());
    } catch (e) {
      return e;
    }
  }

  Future fetchExitDate() async {
    try {
      return timestampDateParser(await fetchExitDateAndTime());
    } catch (e) {
      return e;
    }
  }

  Future fetchEntryTime() async {
    try {
      return timestampTimeParser(await fetchEntryDateAndTime());
    } catch (e) {
      return e;
    }
  }

  Future fetchExitTime() async {
    try {
      return timestampTimeParser(await fetchExitDateAndTime());
    } catch (e) {
      return e;
    }
  }

  /// disposing off used {@controllers}
  @override
  void dispose() {
    ownerContactNumberController.dispose();
    driverNameController.dispose();
    vehicleTypeController.dispose();
    numberOfWheelsController.dispose();
    ownerNameController.dispose();
    vehicleNumberController.dispose();

    super.dispose();
  }
}
