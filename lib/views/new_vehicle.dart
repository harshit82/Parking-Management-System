import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:vehicle_parking_management/controllers/parking_controller.dart';
import 'package:vehicle_parking_management/controllers/vehicle_controller.dart';
import 'package:vehicle_parking_management/models/vehicle.dart';
import 'package:vehicle_parking_management/services/upload_image.dart';
import 'package:vehicle_parking_management/utils/colors.dart';
import 'package:vehicle_parking_management/utils/snack_bar.dart';
import 'package:vehicle_parking_management/utils/utility.dart';
import 'package:vehicle_parking_management/services/firebase.dart';

/// {@obj operation}
CRUD operation = CRUD();

/// {@obj newVehicle}
Vehicle newVehicle = Vehicle();

/// @controller
final parkingController = Get.put(ParkingController());

VehicleController vehicleController = VehicleController();

class NewVehicle extends StatefulWidget {
  const NewVehicle({Key? key}) : super(key: key);

  @override
  State<NewVehicle> createState() => _NewVehicleState();
}

class _NewVehicleState extends State<NewVehicle> {
  /// {@key _formKey}
  final _formKey = GlobalKey<FormState>();

  Future<String> addImageUrl({required String downloadUrl}) async {
    return await operation.updateData(
        data: downloadUrl,
        field: 'Image Url',
        vehicleNumber: newVehicle.vehicleNumber.toString());
  }

  Future<String> addUser() async {
    // adding a new user
    return await operation.addDocument(
        dataToBeAdded: newVehicle.newVehicleDetails(),
        vehicleNumber: newVehicle.vehicleNumber.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("New Vehicle Entry Details"),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Number of Wheels",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: vehicleController.numberOfWheelsController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter number of wheels";
                  } else if (!isNumeric(value)) {
                    return "Please enter a valid value";
                  }
                  return null;
                },
                onChanged: (value) {
                  newVehicle.numberOfWheels = int.parse(
                      vehicleController.numberOfWheelsController.text);
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Owner's Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: vehicleController.ownerNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter vehicle owner's name";
                  }
                  return null;
                },
                onChanged: (value) {
                  newVehicle.ownerName =
                      vehicleController.ownerNameController.text;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Driver's Name",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: vehicleController.driverNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter vehicle driver's name";
                  }
                  return null;
                },
                onChanged: (value) {
                  newVehicle.driverName =
                      vehicleController.driverNameController.text;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Owner contact number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: vehicleController.ownerContactNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter owner's contact number";
                  } else if (!isNumeric(value) || value.length != 10) {
                    return "Please enter a valid 10 digit contact number";
                  }
                  return null;
                },
                onChanged: ((value) {
                  newVehicle.ownerContactNumber = int.parse(
                      vehicleController.ownerContactNumberController.text);
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Vehicle number",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                controller: vehicleController.vehicleNumberController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter vehicle number";
                  }
                  return null;
                },
                onChanged: (value) {
                  newVehicle.vehicleNumber =
                      vehicleController.vehicleNumberController.text;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
                hint: const Text("Select vehicle type"),
                items: getVehicleList()
                    .map((String value) =>
                        DropdownMenuItem(value: value, child: Text(value)))
                    .toList(),
                onChanged: (newValue) {
                  newVehicle.vehicleType = newValue.toString();
                },
                validator: (value) {
                  if (value == null) {
                    return "Please choose a vehicle type";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const UploadImage(),
                      ));
                },
                icon: const FaIcon(FontAwesomeIcons.car),
                label: const Text("Upload Vehicle Image"),
              ),
              const Spacer(),
              ElevatedButton(
                  // button to validate form and save data
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        _formKey.currentState?.save();

                        displaySnackBar(
                            context: context, text: "Details saved");

                        /// printing data to be added to check
                        /// if correct data has been added or not
                        debugPrint(newVehicle.toString());

                        /// invoking addUser() function to add user data to database
                        String statusOfNewUser = addUser() as String;
                        debugPrint(statusOfNewUser);

                        /// adding the download url to the URL field of the user
                        String statusOfUrl =
                            addImageUrl(downloadUrl: downloadUrl) as String;
                        debugPrint(statusOfUrl);

                        /// TODO: Fix the below, after adding new vehicle the following functions are not updating the UI

                        /// decrementing values
                        // parkingDetails.decrementTotalNumberOfSlots();
                        parkingController.decrementTotalNumberOfSlots();
                        debugPrint(parkingController
                            .totalParkingSlotsControllerText as String);
                        if (newVehicle.numberOfWheels == 2) {
                          //parkingDetails.decrementNumberOfTwoWheelerSlots();
                          parkingController.decrementTwoWheelerSlots();
                          debugPrint(parkingController
                              .numberOfTwoWheelerSlotsControllerText as String);
                        } else if (newVehicle.numberOfWheels == 4) {
                          //parkingDetails.decrementNumberOfTwoWheelerSlots();
                          parkingController.decrementFourWheelerSlots();
                          debugPrint(parkingController
                                  .numberOfFourWheelerSlotsControllerText
                              as String);
                        }

                        /// return to previous screen
                        Navigator.pop(context);
                      });
                    }
                  },
                  child: const Text("Save")),
            ],
          ),
        ),
      ),
    );
  }
}
