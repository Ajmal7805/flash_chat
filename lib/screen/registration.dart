import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/roundedbutton.dart';
import 'chatscreen.dart';

class Registration extends StatefulWidget {
  static const String id = 'registration';
  const Registration({super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  bool spinner = false;
  final _auth = FirebaseAuth.instance;
  String email = 'email@gmail.com';
  String password = '123';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: spinner,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: 300.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 48.0,
              ),
              TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                  decoration:
                      ktextdecoration.copyWith(hintText: 'Enter Your E-mail')),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                  keyboardType: TextInputType.number,
                  obscureText: true,
                  onChanged: (value) {
                    password = value;
                  },
                  decoration: ktextdecoration.copyWith(
                      hintText: 'Enter Your Password')),
              const SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                  title: "Register",
                  color: Colors.blueAccent,
                  onPressed: ()  async {
        


                    setState(() {
                      spinner = true;
                    }); 
                    try {
                      final newUser =
                          await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                      if (newUser != null) {
                        Navigator.pushNamed(context, Chatscreen.id);
                      }
                      setState(() {
                        spinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }



                    
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
