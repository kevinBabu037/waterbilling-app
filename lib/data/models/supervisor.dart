
class Supervisor {
  final String name;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String state;
  final String postalCode;
  final String zoneId;

  Supervisor({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.zoneId,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'state': state,
      'postal_code': postalCode,
      'zone_id': zoneId,
    };
  }


}
