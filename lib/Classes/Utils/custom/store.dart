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
