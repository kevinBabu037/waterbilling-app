import 'dart:convert';
import 'dart:developer';
import 'package:super_admin_app/application/utils/endpoints.dart';
import 'package:super_admin_app/data/models/agent.dart';
import 'package:super_admin_app/data/secure_storage/secure_storage.dart';
import 'package:http/http.dart' as http;

class AgentSetvice {

  Future<bool> addAgent(Agent agentModel) async {
    final url = Uri.parse('${EndPoint.baseUrl}${EndPoint.addAgent}');
    SecureStorage secureStorage = SecureStorage();

    String accessToken = await secureStorage.readSecureData("AccessToken");

    try {
      final response = await http.post(
        url,
        headers: { 
          'Content-Type': 'application/json', 
          'x-api-key': EndPoint.apikey,
          'x-access-token': accessToken,
        },
        body: jsonEncode(agentModel.toJson()), 
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
}
