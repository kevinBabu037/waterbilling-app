import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:super_admin_app/application/utils/endpoints.dart';
import 'package:super_admin_app/data/secure_storage/secure_storage.dart';
import 'package:super_admin_app/data/shared_pref/shared_pref.dart';

class LoginService {

  SecureStorage secureStorage =SecureStorage();

  Future<bool> tenantLogin(String tenantID, String password) async {
    final url = Uri.parse('${EndPoint.baseUrl}${EndPoint.tenantLogin}');
    final body = {
      "tenant_userid": tenantID,
      "Password": password
    };

    try {
      final response = await http.post(
        url,
        headers: {
            'Content-Type': 'application/json',
          'x-api-key' : EndPoint.apikey,
        },
        body: jsonEncode(body),
      );
      log(response.body);

      if (response.statusCode == 200) { 
        final jsonResponse = jsonDecode(response.body);

        // Extract tokens from response
        final accessToken = jsonResponse['after execution']['AccessToken'];
        final refreshToken = jsonResponse['after execution']['RefreshToken'];

        // Store tokens securely
        await secureStorage.writeSecureData('AccessToken', accessToken); 
        await secureStorage.writeSecureData('RefreshToken', refreshToken);
        await SharedPreferenses.saveBoolValue(true); 
        return true;
      }
    } catch (e) {
      log("----------${e.toString()}");
    }
    return false;
  }
}
