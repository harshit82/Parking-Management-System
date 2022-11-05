import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_parking_management/controllers/vehicle_controller.dart';
import 'package:vehicle_parking_management/models/parking_charges.dart';
import 'package:vehicle_parking_management/models/parking_details.dart';
import 'package:vehicle_parking_management/utils/colors.dart';

final _vehicle = Get.put(VehicleController());

/// @obj of ParkingDetails() class
ParkingDetails _parkingDetails = ParkingDetails();

/// @obj of ParkingCharges() class
ParkingCharges _parkingCharges = ParkingCharges();

VehicleController _vehicleController = VehicleController();

class Receipt extends StatelessWidget {
  const Receipt({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("Generated Receipt"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            ListView(children: [
              ListTile(
                leading: const Text("Parking Location"),
                trailing: Text(_parkingDetails.parkingLocation.toString()),
              ),
              ListTile(
                leading: const Text("Vehicle Type"),
                trailing: Text(_vehicle.vehicleTypeControllerText.toString()),
              ),
              ListTile(
                leading: const Text("Number of Wheels"),
                trailing:
                    Text(_vehicle.numberOfWheelsControllerText.toString()),
              ),
              ListTile(
                leading: const Text("Vehicle Number"),
                trailing: Text(_vehicle.vehicleNumberControllerText.toString()),
              ),
              ListTile(
                leading: const Text("Charges"),
                trailing: Text(_parkingDetails.perHourCharges.toString()),
              ),
              ListTile(
                leading: const Text("Entry Date"),
                trailing: Text(_vehicleController.fetchEntryDate().toString()),
              ),
              ListTile(
                leading: const Text("Exit Date"),
                trailing: Text(_vehicleController.fetchExitDate().toString()),
              ),
              ListTile(
                leading: const Text("Entry Time"),
                trailing: Text(_vehicleController.fetchEntryTime().toString()),
              ),
              ListTile(
                leading: const Text("Exit Time"),
                trailing: Text(_vehicleController.fetchExitTime().toString()),
              ),
              ListTile(
                leading: const Text("Duration"),
                trailing: Text(_parkingCharges.getDifference().toString()),
              ),
              ListTile(
                leading: const Text("Final amount"),
                trailing: Text(_parkingCharges.getFinalAmount().toString()),
              ),
            ]),
            // TODO: Add makeImageGrid() to display image
          ],
        ),
      ),
    ));
  }
}

Widget makeImageGrid() {
  return FutureBuilder(
      future: getImages(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.connectionState == ConnectionState.none) {
          return const Text("No Data");
        }
        return GridView.builder(
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1),
          itemCount: snapshot.data!.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return GridTile(
                child: Image.network(
              snapshot.data!.docs[index].get("url"),
              fit: BoxFit.fill,
            ));
          },
        );
      });
}

Future<QuerySnapshot> getImages() {
  return FirebaseFirestore.instance.collection('users').get();
}
