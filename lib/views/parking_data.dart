import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vehicle_parking_management/controllers/parking_controller.dart';
import 'package:vehicle_parking_management/models/parking_details.dart';
import 'package:vehicle_parking_management/views/enter_parking_space_details.dart';
import 'package:vehicle_parking_management/views/new_vehicle.dart';
import 'package:vehicle_parking_management/utils/colors.dart';

class ParkingData extends StatelessWidget {
  ParkingData({Key? key}) : super(key: key);

  /// @controller
  final parkingController = Get.put(ParkingController());

  /// {@obj}
  final ParkingDetails parkingDetails = ParkingDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'Parking Data',
        ),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const EnterParkingSpaceDetails()));
              },
              icon: const Icon(
                Icons.edit,
              )),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (parkingController.totalParkingSlotsControllerText > 0) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NewVehicle(),
                ),
              );
            } else {
              Fluttertoast.showToast(msg: "No more slots left");
            }
          },
          child: const Icon(Icons.add)),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView(
          children: [
            Card(
              child: ListTile(
                leading: const Text(
                  "Total",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                title: Center(
                  child: Obx((() => Text(parkingController
                      .totalParkingSlotsControllerText
                      .toString()))),
                ),
                trailing: const Text("slots"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const FaIcon(FontAwesomeIcons.car),
                title: Center(
                  child: Obx((() => Text(parkingController
                      .numberOfFourWheelerSlotsControllerText.value
                      .toString()))),
                ),
                trailing: const Text("slots"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const FaIcon(FontAwesomeIcons.motorcycle),
                title: Center(
                    child: Obx((() => Text(parkingController
                        .numberOfTwoWheelerSlotsControllerText.value
                        .toString())))),
                trailing: const Text("slots"),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.location_pin),
                title: Center(
                  child: Obx((() => Text(
                      parkingController.parkingLocationControllerText.value))),
                ),
              ),
            ),
            Card(
              child: ListTile(
                leading: const FaIcon(FontAwesomeIcons.moneyBill),
                title: Center(
                  child: Obx((() => Text(parkingController
                      .perHourChargesControllerText.value
                      .toString()))),
                ),
                trailing: const Text("rupees"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
