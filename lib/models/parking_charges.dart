import 'package:get/get.dart';
import 'package:vehicle_parking_management/controllers/parking_controller.dart';
import 'package:vehicle_parking_management/controllers/vehicle_controller.dart';

ParkingController _formController = ParkingController();
VehicleController _vehicleController = VehicleController();

class ParkingCharges {
  RxDouble pricePerHour = _formController.perHourChargesControllerText;

  // TODO: Fix, not working
  DateTime entryDateAndTime =
      _vehicleController.fetchEntryDateAndTime() as DateTime;
  DateTime exitDateAndTime =
      _vehicleController.fetchExitDateAndTime() as DateTime;

  Duration getDifference() {
    return exitDateAndTime.difference(entryDateAndTime);
  }

  double getFinalAmount() {
    return pricePerHour * double.parse(getDifference().toString());
  }
}
