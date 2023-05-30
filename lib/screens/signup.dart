import 'package:flutter/material.dart';
import 'package:todo_app/screens/login.dart';
import 'package:todo_app/auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key});

  @override
  State<SignUp> createState() => _SignUpState();
}

TextEditingController emailController = TextEditingController();
TextEditingController passwordController = TextEditingController();
TextEditingController nameController = TextEditingController();

class _SignUpState extends State<SignUp> {
  bool isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        backgroundColor: Color.fromARGB(255, 77, 182, 172),
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
                  controller: nameController,
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
                  controller: emailController,
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
                  controller: passwordController,
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
                        (states) => Color.fromARGB(255, 92, 147, 241),
                      ),
                    ),
                    child: isloading
                        ? CircularProgressIndicator(
                            color: Colors.black,
                          )
                        : Text(
                            'Sign Up',
                            style:
                                TextStyle(fontSize: 23.0, color: Colors.black),
                          ),
                    onPressed: () {
                      print('sign up');
                      createUser(emailController.text, passwordController.text,
                              nameController.text)
                          .then((value) {
                        if (value == "success") {
                          setState(() {
                            isloading = true;
                          });
                          Future.delayed(Duration(seconds: 5), () {
                            setState(() {
                              isloading = false;
                              Navigator.pushReplacementNamed(context, '/login');
                            });
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(value),
                            ),
                          );
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/login');
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
