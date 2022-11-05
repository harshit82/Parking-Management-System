import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ParkingController extends GetxController {
  // {@controllers} for text fields
  final totalParkingSlotsController = TextEditingController();
  final numberOfFourWheelerSlotsController = TextEditingController();
  final numberOfTwoWheelerSlotsController = TextEditingController();
  final parkingLocationController = TextEditingController();
  final perHourChargesController = TextEditingController();

  RxInt totalParkingSlotsControllerText = 0.obs;
  RxInt numberOfFourWheelerSlotsControllerText = 0.obs;
  RxInt numberOfTwoWheelerSlotsControllerText = 0.obs;
  RxString parkingLocationControllerText = ''.obs;
  RxDouble perHourChargesControllerText = 0.0.obs;

  @override
  void onInit() {
    totalParkingSlotsController.addListener(() {
      totalParkingSlotsControllerText.value =
          int.parse(totalParkingSlotsController.text);
    });
    numberOfFourWheelerSlotsController.addListener(() {
      numberOfFourWheelerSlotsControllerText.value =
          int.parse(numberOfFourWheelerSlotsController.text);
    });
    numberOfTwoWheelerSlotsController.addListener(() {
      numberOfTwoWheelerSlotsControllerText.value =
          int.parse(numberOfTwoWheelerSlotsController.text);
    });
    parkingLocationController.addListener(() {
      parkingLocationControllerText.value = parkingLocationController.text;
    });
    perHourChargesController.addListener(() {
      perHourChargesControllerText.value =
          double.parse(perHourChargesController.text);
    });
    super.onInit();
  }

  void decrementTotalNumberOfSlots() {
    totalParkingSlotsControllerText--;
  }

  void decrementTwoWheelerSlots() {
    numberOfTwoWheelerSlotsControllerText--;
  }

  void decrementFourWheelerSlots() {
    numberOfFourWheelerSlotsControllerText--;
  }
}
