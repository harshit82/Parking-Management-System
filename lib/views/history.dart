import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vehicle_parking_management/controllers/vehicle_controller.dart';
import 'package:vehicle_parking_management/utils/date_time_parsers.dart';
import 'package:vehicle_parking_management/views/generate_receipt.dart';
import 'package:vehicle_parking_management/services/firebase.dart';
import '../utils/colors.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

/// @obj
CRUD _crud = CRUD();

final vehicle = Get.find<VehicleController>();

class _HistoryScreenState extends State<HistoryScreen> {
  late String _vehicleNumber;

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('users').snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text("History"),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Something went wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            shrinkWrap: true,
            children: snapshot.data!.docs
                .map((DocumentSnapshot document) {
                  Map<String, dynamic> data =
                      document.data()! as Map<String, dynamic>;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onDoubleTap: (() {
                        showModalBottomSheet(
                            backgroundColor: Colors.indigoAccent[100],
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10)),
                            ),
                            context: context,
                            builder: (context) {
                              return Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Wrap(
                                    children: [
                                      ListTile(
                                        textColor: Colors.white,
                                        title: const Text("Amount"),
                                        trailing: Text(
                                          data['Final Amount'].toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      ListTile(
                                        textColor: Colors.white,
                                        title: const Text("Owner Name"),
                                        trailing: Text(
                                          data['Owner Name'] ?? 'NA',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      ListTile(
                                        textColor: Colors.white,
                                        title: const Text("Driver Name"),
                                        trailing: Text(
                                          data['Driver Name'] ?? 'NA',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      ListTile(
                                        textColor: Colors.white,
                                        title:
                                            const Text("Owner Contact Number"),
                                        trailing: Text(
                                          data['Owner Contact Number']
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      ListTile(
                                        textColor: Colors.white,
                                        title: const Text("Vehicle Type"),
                                        trailing: Text(
                                          data['Vehicle Type'] ?? 'NA',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      ListTile(
                                        textColor: Colors.white,
                                        title: const Text("Entry time"),
                                        trailing: Text(
                                          data['Entry Date and Time'] != null
                                              ? timestampTimeParser(
                                                  data['Entry Date and Time'])
                                              : 'NA',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 4.0, right: 4.0),
                                    child: ElevatedButton(
                                        onPressed: () {
                                          setState(() {
                                            /// Initializing the @var {_vehicleNumber} from the fetched data
                                            _vehicleNumber =
                                                data['Vehicle Number'];
                                            debugPrint(_vehicleNumber);

                                            /// updating details
                                            updateVehicleData(
                                                vehicleNumber: _vehicleNumber);

                                            /// Go to receipt screen
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Receipt()),
                                            );
                                          });
                                        },
                                        child: const Text(
                                          "Vehicle Exit",
                                          style: TextStyle(
                                              color: Colors.indigoAccent),
                                        )),
                                  ),
                                ],
                              );
                            });
                      }),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        elevation: 10,
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text("Vehicle Number"),
                              trailing: Text(
                                data['Vehicle Number'] ?? 'NA',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              title: const Text("Number of Wheels"),
                              trailing: Text(
                                data['Number of Wheels'].toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              title: const Text("Entry date"),
                              trailing: Text(
                                data['Entry Date and Time'] != null
                                    ? timestampDateParser(
                                        data['Entry Date and Time'])
                                    : "NA",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              title: const Text("Exit date"),
                              trailing: Text(
                                data['Exit Date and Time'] == null
                                    ? 'NA'
                                    : timestampDateParser(
                                        data['Exit Date and Time']),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            ListTile(
                              title: const Text("Is Present"),
                              trailing: Text(
                                data['Is Present'] == true ? "Yes" : "No",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })
                .toList()
                .cast(),
          );
        },
      ),
    );
  }
}

Future<void> updateVehicleData({required String vehicleNumber}) async {
  /// Updating parameters
  await _crud.updateData(
      field: 'Exit Date and Time',
      data: getCurrentDateAndTime(),
      vehicleNumber: vehicleNumber);
  await _crud.updateData(
      field: 'Is Present', data: false, vehicleNumber: vehicleNumber);
}
