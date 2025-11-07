import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../utils/formatters/formatters.dart';

class AddressModel {
  String id;
  final String name;
  final String phoneNumber;
  final String street;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final DateTime? dateTime;
  bool selectedAddress;

  AddressModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.street,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.dateTime,
    this.selectedAddress = true,
  });

  String get formattedPhoneNo => CFormatter.formatPhoneNumber(phoneNumber);

  static AddressModel empty() => AddressModel(
    id: '',
    name: '',
    phoneNumber: '',
    street: '',
    city: '',
    state: '',
    postalCode: '',
    country: '',
    selectedAddress: false,
  );

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'PhoneNumber': phoneNumber,
      'Street': street,
      'City': city,
      'State': state,
      'PostalCode': postalCode,
      'Country': country,
      'DateTime': dateTime ?? DateTime.now(),
      'SelectedAddress': selectedAddress,
    };
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    DateTime? parsedDate;
    final dt = json['DateTime'];
    if (dt != null) {
      if (dt is Timestamp)
        parsedDate = dt.toDate();
      else if (dt is DateTime)
        parsedDate = dt;
      // else ignore/leave null
    }

    return AddressModel(
      id: json['Id'] ?? '',
      name: json['Name'] ?? '',
      phoneNumber: json['PhoneNumber'] ?? '',
      street: json['Street'] ?? '',
      city: json['City'] ?? '',
      state: json['State'] ?? '',
      postalCode: json['PostalCode'] ?? '',
      country: json['Country'] ?? '',
      dateTime: parsedDate,
      selectedAddress: json['SelectedAddress'] ?? false,
    );
  }

  /// Alias expected by other code (fromMap)
  factory AddressModel.fromMap(Map<String, dynamic> map) =>
      AddressModel.fromJson(map);

  factory AddressModel.fromDocumentSnapshot(DocumentSnapshot snapshot) {
    final data =
        (snapshot.data() as Map<String, dynamic>?) ?? <String, dynamic>{};

    DateTime? parsedDate;
    final dt = data['DateTime'];
    if (dt != null) {
      if (dt is Timestamp)
        parsedDate = dt.toDate();
      else if (dt is DateTime)
        parsedDate = dt;
    }

    return AddressModel(
      id: snapshot.id,
      name: data['Name'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      street: data['Street'] ?? '',
      city: data['City'] ?? '',
      state: data['State'] ?? '',
      postalCode: data['PostalCode'] ?? '',
      country: data['Country'] ?? '',
      dateTime: parsedDate,
      selectedAddress: data['SelectedAddress'] ?? false,
    );
  }

  @override
  String toString() {
    return '$street, $city, $state $postalCode, $country';
  }
}
