import 'package:shared_preferences/shared_preferences.dart';

void saveApiKey(String apiKey) async {
  final SharedPreferences sf = await SharedPreferences.getInstance();
  sf.setString('key', apiKey);
}

void getApiKey() async {
  final SharedPreferences sf = await SharedPreferences.getInstance();
  sf.getString('key');
}
