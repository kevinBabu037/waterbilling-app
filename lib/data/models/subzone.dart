
class SubZoneResponse {
  final int statusCode;
  final String message;
  final List<SubZone> subZones;

  SubZoneResponse({
    required this.statusCode,
    required this.message,
    required this.subZones,
  });

  factory SubZoneResponse.fromJson(Map<String, dynamic> json) {
    return SubZoneResponse(
      statusCode: json['status_code'],
      message: json['message'],
      subZones: (json['after execution'] as List)
          .map((e) => SubZone.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

}

class SubZone {
  final String subZoneId;
  final String zoneName;

  SubZone({
    required this.subZoneId,
    required this.zoneName,
  });

  factory SubZone.fromJson(Map<String, dynamic> json) {
    return SubZone(
      subZoneId: json['sub_zone_id'],
      zoneName: json['zone_name'],
    );
  }

}
