import 'package:appwrite/appwrite.dart';

import 'package:todo_app/sharedPref.dart';
import 'controllers/todo_provider.dart';

Client client = Client()
    .setEndpoint('http://192.168.34.132/v1')
    .setProject('646bd7196eac1d3139d1')
    .setSelfSigned(status: true);

Account account = Account(client);

// Registring a user (Sign Up)
Future<String> createUser(String email, String password, String name) async {
  try {
    final user = await account.create(
        userId: ID.unique(), email: email, password: password, name: name);
    print('user created');
    return "success";
  } on AppwriteException catch (e) {
    return e.message.toString();
  }
}

// Login user
Future loginUser(String email, String password) async {
  try {
    final user =
        await account.createEmailSession(email: email, password: password);
    await UserSavedData.saveEmail(email);

    return true;
    print('User Logged in');
  } catch (e) {
    return false;
    print(e);
  }
}

// logout a user
Future logoutUser() async {
  try {
    await account.deleteSession(sessionId: 'current');
    print('User logged out');

    return true;
  } catch (e) {
    return false;
    print(e);
  }
}

// check user is authenticated or not
Future checkUserAuth() async {
  try {
    await account.getSession(sessionId: 'current');
    // if exist true
    return true;
  } catch (e) {
    return false;
    print(e);
  }
}
