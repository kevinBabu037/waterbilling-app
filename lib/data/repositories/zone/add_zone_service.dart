import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:super_admin_app/application/utils/endpoints.dart';
import 'package:super_admin_app/data/models/zonelist.dart';
import 'package:super_admin_app/data/secure_storage/secure_storage.dart';

class AddZoneService {

  Future<bool> addZone(String name, String description) async {
    final url = Uri.parse('${EndPoint.baseUrl}${EndPoint.addZone}');
    final body = {
      "zone_name": name,
      "zone_description": description
    };

    SecureStorage secureStorage = SecureStorage();

    String accessToken = await secureStorage.readSecureData("AccessToken");
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': EndPoint.apikey,
          "x-access-token": accessToken
        },
        body: jsonEncode(body),
      );
      log(response.body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final zoneId = responseData['after execution']['zone_id'];

        await secureStorage.writeSecureData('zone_id', zoneId);

        return true;
      }
    } catch (e) {
      log("----------${e.toString()}");
    }
    return false;
  }

   


  Future<List<Zone>> getAllZone() async {
  final url = Uri.parse('${EndPoint.baseUrl}${EndPoint.getZones}');

    SecureStorage secureStorage = SecureStorage();

    String accessToken = await secureStorage.readSecureData("AccessToken");
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': EndPoint.apikey,
          "x-access-token" : accessToken,
        },
      );
      log(response.body);

      if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final zonesResponse = ZonesResponse.fromJson(jsonResponse);
      return zonesResponse.zones;
      }
      
    } catch (e) {
      log("----------${e.toString()}");
    }
    return [];
  }


}