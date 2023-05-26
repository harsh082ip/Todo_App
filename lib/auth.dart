import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('http://192.168.87.132/v1')
    .setProject('646bd7196eac1d3139d1')
    .setSelfSigned(status: true);

Account account = Account(client);

// Registring a user (Sign Up)
Future createUser(String email, String password, String name) async {
  try {
    final user = await account.create(
        userId: ID.unique(), email: email, password: password, name: name);
    print('user created');
  } catch (e) {
    print(e);
  }
}

// Login user
Future loginUser(String email, String password) async {
  try {
    final user =
        await account.createEmailSession(email: email, password: password);
    print('User Logged in');
  } catch (e) {
    print(e);
  }
}

Future logoutUser() async {
  account.deleteSession(sessionId: 'current');
}
