import 'dart:convert';
import 'package:vehicle_parking_management/utils/date_time_parsers.dart';

List<String> vehicleList = [
  "Bike",
  "Sedan",
  "Hatchback",
  "Jeep",
  "Limousine",
  "Sports Car",
  "Luxury Cars",
  "Wagon",
  "Convertible",
  "Van",
  "Crossover",
  "Pickup Truck",
  "Scooter",
  "Others"
];

List<String> getVehicleList() {
  return vehicleList;
}

class Vehicle {
  int? numberOfWheels;
  String? vehicleType;
  String? driverName;
  String? ownerName;
  int? ownerContactNumber;
  String? vehicleNumber;
  bool? isPresent;
  DateTime? entryDateAndTime;
  DateTime? exitDateAndTime;
  double? finalAmount;
  String? imageUrl;
  Vehicle({
    this.numberOfWheels,
    this.vehicleType,
    this.driverName,
    this.ownerName,
    this.ownerContactNumber,
    this.vehicleNumber,
    this.isPresent,
    this.entryDateAndTime,
    this.exitDateAndTime,
    this.finalAmount,
    this.imageUrl,
  });

  Vehicle copyWith({
    int? numberOfWheels,
    String? vehicleType,
    String? driverName,
    String? ownerName,
    int? ownerContactNumber,
    String? vehicleNumber,
    bool? isPresent,
    DateTime? entryDateAndTime,
    DateTime? exitDateAndTime,
    double? finalAmount,
    String? imageUrl,
  }) {
    return Vehicle(
      numberOfWheels: numberOfWheels ?? this.numberOfWheels,
      vehicleType: vehicleType ?? this.vehicleType,
      driverName: driverName ?? this.driverName,
      ownerName: ownerName ?? this.ownerName,
      ownerContactNumber: ownerContactNumber ?? this.ownerContactNumber,
      vehicleNumber: vehicleNumber ?? this.vehicleNumber,
      isPresent: isPresent ?? this.isPresent,
      entryDateAndTime: entryDateAndTime ?? this.entryDateAndTime,
      exitDateAndTime: exitDateAndTime ?? this.exitDateAndTime,
      finalAmount: finalAmount ?? this.finalAmount,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> newVehicleDetails() {
    return <String, dynamic>{
      'Number of Wheels': numberOfWheels,
      'Vehicle Type': vehicleType,
      'Driver Name': driverName,
      'Owner Name': ownerName,
      'Owner Contact Number': ownerContactNumber,
      'Vehicle Number': vehicleNumber,
      'Is Present': true,
      'Entry Date and Time': getCurrentDateAndTime(),
      'Exit Date and Time': exitDateAndTime?.millisecondsSinceEpoch,
      'Final Amount': 0.0,
      'Image Url': imageUrl,
    };
  }

  factory Vehicle.fromMap(Map<String, dynamic> map) {
    return Vehicle(
      numberOfWheels:
          map['numberOfWheels'] != null ? map['numberOfWheels'] as int : null,
      vehicleType:
          map['vehicleType'] != null ? map['vehicleType'] as String : null,
      driverName:
          map['driverName'] != null ? map['driverName'] as String : null,
      ownerName: map['ownerName'] != null ? map['ownerName'] as String : null,
      ownerContactNumber: map['ownerContactNumber'] != null
          ? map['ownerContactNumber'] as int
          : null,
      vehicleNumber:
          map['vehicleNumber'] != null ? map['vehicleNumber'] as String : null,
      isPresent: map['isPresent'] != null ? map['isPresent'] as bool : null,
      entryDateAndTime: map['entryDateAndTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['entryDateAndTime'] as int)
          : null,
      exitDateAndTime: map['exitDateAndTime'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['exitDateAndTime'] as int)
          : null,
      finalAmount:
          map['finalAmount'] != null ? map['finalAmount'] as double : null,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Vehicle.fromJson(var source) =>
      Vehicle.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Vehicle(numberOfWheels: $numberOfWheels, vehicleType: $vehicleType, driverName: $driverName, ownerName: $ownerName, ownerContactNumber: $ownerContactNumber, vehicleNumber: $vehicleNumber, isPresent: $isPresent, entryDateAndTime: $entryDateAndTime, exitDateAndTime: $exitDateAndTime, finalAmount: $finalAmount, imageUrl: $imageUrl)';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'numberOfWheels': numberOfWheels,
      'vehicleType': vehicleType,
      'driverName': driverName,
      'ownerName': ownerName,
      'ownerContactNumber': ownerContactNumber,
      'vehicleNumber': vehicleNumber,
      'isPresent': isPresent,
      'entryDateAndTime': entryDateAndTime?.millisecondsSinceEpoch,
      'exitDateAndTime': exitDateAndTime?.millisecondsSinceEpoch,
      'finalAmount': finalAmount,
      'imageUrl': imageUrl,
    };
  }
}
