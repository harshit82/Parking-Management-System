/// Take input regarding the parking details

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_parking_management/controllers/parking_controller.dart';
import 'package:vehicle_parking_management/models/parking_details.dart';
import 'package:vehicle_parking_management/utils/colors.dart';
import 'package:vehicle_parking_management/utils/snack_bar.dart';
import '../home.dart';
import '../utils/numeric.dart';

class EnterParkingSpaceDetails extends StatefulWidget {
  const EnterParkingSpaceDetails({Key? key}) : super(key: key);

  @override
  State<EnterParkingSpaceDetails> createState() =>
      _EnterParkingSpaceDetailsState();
}

class _EnterParkingSpaceDetailsState extends State<EnterParkingSpaceDetails> {
  /// {@controller}
  final parkingController = Get.find<ParkingController>();

  /// {@key}
  final _formKey = GlobalKey<FormState>();

  /// {@obj parkingDetails} of class ParkingDetails
  ParkingDetails parkingDetails = ParkingDetails();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Parking Space Details"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Total Parking Slots",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorStyle: const TextStyle(color: Colors.redAccent)),
                controller: parkingController.totalParkingSlotsController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter correct value";
                  }
                  if (!isNumeric(value)) {
                    return "Please enter a number";
                  }
                  return null;
                },
                onChanged: ((value) {
                  parkingDetails.totalParkingSlots = int.parse(
                      parkingController.totalParkingSlotsController.text);
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Number of 4 wheeler slots",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorStyle: const TextStyle(color: Colors.redAccent)),
                controller:
                    parkingController.numberOfFourWheelerSlotsController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter correct value";
                  }
                  if (!isNumeric(value)) {
                    return "Please enter a number";
                  }
                  if (parkingController.numberOfFourWheelerSlotsControllerText >
                      parkingController.totalParkingSlotsControllerText
                          .toInt()) {
                    return "Invalid, more than total slots";
                  }
                  return null;
                },
                onChanged: (value) {
                  parkingDetails.numberOfFourWheelerSlots = int.parse(
                      parkingController
                          .numberOfFourWheelerSlotsController.text);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Number of 2 wheeler slots",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorStyle: const TextStyle(color: Colors.redAccent)),
                controller: parkingController.numberOfTwoWheelerSlotsController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter correct value";
                  }
                  if (!isNumeric(value)) {
                    return "Please enter a number";
                  }
                  if (parkingController.numberOfTwoWheelerSlotsControllerText >
                      parkingController.totalParkingSlotsControllerText
                          .toInt()) {
                    return "Invalid, more than total slots";
                  }
                  return null;
                },
                onChanged: ((value) {
                  parkingDetails.numberOfTwoWheelerSlots = int.parse(
                      parkingController.numberOfTwoWheelerSlotsController.text);
                }),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                    labelText: "Parking Location",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                    errorStyle: const TextStyle(color: Colors.redAccent)),
                controller: parkingController.parkingLocationController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter correct value";
                  }
                  return null;
                },
                onChanged: (value) {
                  parkingDetails.parkingLocation =
                      parkingController.parkingLocationController.text;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "Per Hour Charges",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  errorStyle: const TextStyle(color: Colors.redAccent),
                ),
                controller: parkingController.perHourChargesController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter correct value";
                  }
                  if (!isNumeric(value)) {
                    return "Please enter a number";
                  }
                  return null;
                },
                onChanged: ((value) {
                  parkingDetails.perHourCharges =
                      parkingController.perHourChargesController.text as double;
                }),
              ),
              const Spacer(),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      setState(() {
                        // saving the form
                        _formKey.currentState?.save();

                        debugPrint(parkingDetails.toString());

                        displaySnackBar(
                            context: context,
                            text: "Details Saved Successfully");

                        // going to parking data page
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const Home()));
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
