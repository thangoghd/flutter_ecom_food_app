class AdressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String _address;
  late String? _latitude;
  late String? _langitude;

  AdressModel({
    id,
    required addressType,
    contactPersonName,
    contactPersonNumber,
    location,
    latitude,
    longitude,
  }) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _address = location;
    _latitude = latitude;
    _langitude = longitude;
  }

  String get address => _address;
  String get addressType => _addressType;
  String get contactPersonName => _contactPersonName!;
  String get contactPersonNumber => _contactPersonNumber!;
  String get latitude => _latitude!;
  String get langtitude => _langitude!;

  AdressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['address_type'];
    _contactPersonName = json['contact_person_name'];
    _contactPersonNumber = json['contact_person_number'];
    _address = json['location'];
    _latitude = json['latitude'];
    _langitude = json['longitude'];
  }
}
