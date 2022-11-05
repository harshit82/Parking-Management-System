// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ParkingDetails {
  // {@params}
  int? totalParkingSlots;
  int? numberOfFourWheelerSlots;
  int? numberOfTwoWheelerSlots;
  String? parkingLocation;
  double? perHourCharges;

  ParkingDetails({
    this.totalParkingSlots,
    this.numberOfFourWheelerSlots,
    this.numberOfTwoWheelerSlots,
    this.parkingLocation,
    this.perHourCharges,
  });
  // {@func}
  void incrementTotalNumberOfSlots() {
    totalParkingSlots = totalParkingSlots! + 1;
  }

  void incrementNumberOfFourWheelerSlots() {
    numberOfFourWheelerSlots = numberOfFourWheelerSlots! + 1;
  }

  void incrementNumberOfTwoWheelerSlots() {
    numberOfTwoWheelerSlots = numberOfTwoWheelerSlots! + 1;
  }

  void decrementTotalNumberOfSlots() {
    totalParkingSlots = totalParkingSlots! - 1;
  }

  void decrementNumberOfFourWheelerSlots() {
    numberOfFourWheelerSlots = numberOfFourWheelerSlots! - 1;
  }

  void decrementNumberOfTwoWheelerSlots() {
    numberOfTwoWheelerSlots = numberOfFourWheelerSlots! - 1;
  }

  ParkingDetails copyWith({
    int? totalParkingSlots,
    int? numberOfFourWheelerSlots,
    int? numberOfTwoWheelerSlots,
    String? parkingLocation,
    double? perHourCharges,
  }) {
    return ParkingDetails(
      totalParkingSlots: totalParkingSlots ?? this.totalParkingSlots,
      numberOfFourWheelerSlots:
          numberOfFourWheelerSlots ?? this.numberOfFourWheelerSlots,
      numberOfTwoWheelerSlots:
          numberOfTwoWheelerSlots ?? this.numberOfTwoWheelerSlots,
      parkingLocation: parkingLocation ?? this.parkingLocation,
      perHourCharges: perHourCharges ?? this.perHourCharges,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'totalParkingSlots': totalParkingSlots,
      'numberOfFourWheelerSlots': numberOfFourWheelerSlots,
      'numberOfTwoWheelerSlots': numberOfTwoWheelerSlots,
      'parkingLocation': parkingLocation,
      'perHourCharges': perHourCharges,
    };
  }

  factory ParkingDetails.fromMap(Map<String, dynamic> map) {
    return ParkingDetails(
      totalParkingSlots: map['totalParkingSlots'] != null
          ? map['totalParkingSlots'] as int
          : null,
      numberOfFourWheelerSlots: map['numberOfFourWheelerSlots'] != null
          ? map['numberOfFourWheelerSlots'] as int
          : null,
      numberOfTwoWheelerSlots: map['numberOfTwoWheelerSlots'] != null
          ? map['numberOfTwoWheelerSlots'] as int
          : null,
      parkingLocation: map['parkingLocation'] != null
          ? map['parkingLocation'] as String
          : null,
      perHourCharges: map['perHourCharges'] != null
          ? map['perHourCharges'] as double
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory ParkingDetails.fromJson(String source) =>
      ParkingDetails.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ParkingDetails(totalParkingSlots: $totalParkingSlots, numberOfFourWheelerSlots: $numberOfFourWheelerSlots, numberOfTwoWheelerSlots: $numberOfTwoWheelerSlots, parkingLocation: $parkingLocation, perHourCharges: $perHourCharges)';
  }
}
