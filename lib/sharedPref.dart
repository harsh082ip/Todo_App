import 'package:shared_preferences/shared_preferences.dart';

class UserSavedData {
  static SharedPreferences? preferences;

  // initialize shared preferences
  static Future init() async {
    preferences = await SharedPreferences.getInstance();
  }

  // saving email
  static saveEmail(String email) async {
    print('Email saved: $email');
    return await preferences?.setString('email', email);
  }

  // reading the email
  static String getEmail() {
    final email = preferences?.getString('email');
    print('Email retrieved: $email');
    return email ?? '';
  }
}
