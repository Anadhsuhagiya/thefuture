library student_ai.globals;

import 'package:shared_preferences/shared_preferences.dart';

String? apiKey = '';
bool isAPIValidated = false;
bool openai = false;
bool typing = false;

getAPIKeyFromStorage() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  apiKey = prefs.getString("apiKey");
  print("API KEY === $apiKey");
  isAPIValidated = prefs.getBool("isAPIValidated")!;
}