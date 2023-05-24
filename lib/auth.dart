import 'package:appwrite/appwrite.dart';

Client client = Client()
    .setEndpoint('http://localhost/v1')
    .setProject('646bd7196eac1d3139d1')
    .setSelfSigned(status: true);

Account account = Account(client);

Future createUser() async {
  final user = await account.create(
      userId: ID.unique(),
      email: 'me@appwrite.io',
      password: 'password',
      name: 'My Name');
  print('user created');
}
