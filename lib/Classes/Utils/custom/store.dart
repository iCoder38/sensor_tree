import 'package:sensor_tree/Classes/Utils/imports/barrel_imports.dart';

// store
Future<void> storeBool(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool(key, value);
}

// get
Future<bool> getBool(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(key) ?? false;
}

// delete
Future<void> deleteBool(String key) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(key);
}

//call
Future<Map<String, dynamic>> getBoolWithResponse(String key) async {
  final prefs = await SharedPreferences.getInstance();
  bool? value = prefs.getBool(key);

  if (value == null) {
    return {"success": false, "message": "Key not found", "value": false};
  } else {
    return {"success": true, "message": "Value retrieved", "value": value};
  }
}

// TOKEN
// ✅ Store token
Future<void> storeToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString("token", token);
}

// ✅ Get token
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString("token");
}

// ✅ Delete token
Future<void> deleteToken() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove("token");
}

// ✅ Get token with response
Future<Map<String, dynamic>> getTokenWithResponse() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString("token");

  if (token == null || token.isEmpty) {
    return {"success": false, "message": "Token not found", "token": ""};
  } else {
    return {"success": true, "message": "Token retrieved", "token": token};
  }
}
