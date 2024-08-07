import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;
import 'package:super_admin_app/application/utils/endpoints.dart';
import 'package:super_admin_app/data/models/subzone.dart';
import 'package:super_admin_app/data/secure_storage/secure_storage.dart';

class AddSubZoneService {


  Future<bool> addsubZone(String name, String discription, String parentZoneID) async {
    final url = Uri.parse('${EndPoint.baseUrl}${EndPoint.addSubZone}');

    final body = {  
      "subzone_name":name,
      "subzone_description": discription,
      "parent_zone_id" :parentZoneID
    };
     String accessToken =  await SecureStorage().readSecureData("AccessToken");
    try {
      final response = await http.post( 
        url,
        headers:{ 
          'Content-Type': 'application/json', 
          'x-api-key' : EndPoint.apikey,
          "x-access-token" :accessToken
        },
        body: jsonEncode(body),  
      ); 
      log(response.body);

      if (response.statusCode == 200) { 
        return true;
      }
    } catch (e) {
      log("----------${e.toString()}");
    }
    return false;
  }


   Future<List<SubZone>> getAllSubZone(String id) async {
  final url = Uri.parse('${EndPoint.baseUrl}/tenant/zone/subzone/$id');

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
      final zonesResponse = SubZoneResponse.fromJson(jsonResponse);
      return zonesResponse.subZones;
      }
      
    } catch (e) {
      log("----------${e.toString()}");
    }
    return [];
  }
  
}