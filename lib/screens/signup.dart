import 'package:flutter/material.dart';
import 'package:todo_app/screens/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Colors.white,
      ),
      drawer: const Drawer(),
      body: Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset('assets/images/login_image.png'),
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(color: Colors.black87, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 12.0,
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle: TextStyle(color: Colors.black87, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 12.0,
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, top: 20.0, right: 10.0),
                child: TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    labelStyle:
                        const TextStyle(color: Colors.black87, fontSize: 25),
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.resolveWith<Color?>(
                        (states) => Colors.purple,
                      ),
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(fontSize: 23.0, color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 23.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(
                color: Colors.black,
                thickness: 0.6,
                indent: 20,
                endIndent: 20,
              ),
              const Text(
                '-or login with-',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
              const SizedBox(
                height: 33.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () {
                      print('google icon pressed');
                    },
                    child: Image.asset(
                      'assets/images/google.png',
                      width: 42.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('facebook icon pressed');
                    },
                    child: Image.asset(
                      'assets/images/facebook.png',
                      width: 42.0,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print('github icon pressed');
                    },
                    child: Image.asset(
                      'assets/images/github.png',
                      width: 42.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
