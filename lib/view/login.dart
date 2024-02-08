import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:input_nilai/view/home.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
              child: Container(
            padding: EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/audience.png',
                  height: 200,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Text(
                      'Login',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.5),
                          blurRadius: 5,
                        )
                      ]),
                  child: Column(
                    children: [
                      TextField(
                        controller: email,
                        decoration: InputDecoration(
                            border: InputBorder.none, labelText: 'Email'),
                      ),
                      Divider(),
                      TextField(
                        controller: password,
                        decoration: InputDecoration(
                            border: InputBorder.none, labelText: 'Password'),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    onPressed: () async {
                      try {
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: email.text, password: password.text);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Home(),
                            ),
                            (route) => false);
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'wrong-password') {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content:
                                  Text('Email & password salah, coba lagi'),
                              backgroundColor: Colors.orange.shade400,
                            ));

                            email.clear();
                            password.clear();
                          });
                        } else if (e.code == 'user-not-found') {
                          setState(() {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('User tidak ditemukan'),
                              backgroundColor: Colors.orange.shade400,
                            ));

                            email.clear();
                            password.clear();
                          });
                        }
                      }
                    },
                    child: Text('Login'))
              ],
            ),
          )),
        ],
      ),
    );
  }
}
