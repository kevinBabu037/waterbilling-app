 import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;
import 'package:super_admin_app/application/utils/endpoints.dart';
import 'package:super_admin_app/data/secure_storage/secure_storage.dart';

Future<String> regenerateAccessToken() async {
    final url = Uri.parse('${EndPoint.baseUrl}${EndPoint.regenarateAccessToken}');
  

    SecureStorage secureStorage = SecureStorage();

    String accessToken = await secureStorage.readSecureData("AccessToken");
    String refreshToken = await secureStorage.readSecureData("RefreshToken");
    try {
      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': EndPoint.apikey,
          "x-access-token" : accessToken,
          "x-refresh-token" : refreshToken
        },
      );
      log(response.body);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        String newAccessToken = responseData['after execution']['NewAccessToken']; 
        return newAccessToken; 
      }
      
    } catch (e) {
      log("----------${e.toString()}");
    }
    return "";
  }