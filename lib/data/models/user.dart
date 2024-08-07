class User {
  final String name;
  final String phone;
  final String houseNo;
  final String address;
  final String street;
  final String landmark;
  final String postalCode;
  final String latitude;
  final String longitude;
  final String subZoneId;
  final String zoneId;

  User({
    required this.name,
    required this.phone,
    required this.houseNo,
    required this.address,
    required this.street,
    required this.landmark,
    required this.postalCode,
    required this.latitude,
    required this.longitude,
    required this.subZoneId,
    required this.zoneId,
  });

  // Convert User instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'house_no': houseNo,
      'address': address,
      'street': street,
      'landmark': landmark,
      'postal_code': postalCode,
      'latitude': latitude,
      'longitude': longitude,
      'sub_zone_id': subZoneId,
      'zone_id': zoneId,
    };
  }

}
