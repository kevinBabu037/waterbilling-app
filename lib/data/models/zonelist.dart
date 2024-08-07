


class ZonesResponse {
  final int statusCode;
  final String message;
  final List<Zone> zones;

  ZonesResponse({
    required this.statusCode,
    required this.message,
    required this.zones,
  });

  factory ZonesResponse.fromJson(Map<String, dynamic> json) {
    return ZonesResponse(
      statusCode: json['status_code'] as int,
      message: json['message'] as String,
      zones: (json['after execution'] as List<dynamic>)
          .map((item) => Zone.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

 
}



class Zone {
  final String zoneId;
  final String zoneName;

  Zone({
    required this.zoneId,
    required this.zoneName,
  });

  factory Zone.fromJson(Map<String, dynamic> json) {
    return Zone(
      zoneId: json['zone_id'] as String,
      zoneName: json['zone_name'] as String,
    );
  }


}
