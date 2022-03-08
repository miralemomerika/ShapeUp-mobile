import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shapeup_mobile/models/LoginResponse.dart';
import 'package:shapeup_mobile/models/LoginDto.dart';
import 'package:shapeup_mobile/services/HttpService.dart';  

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  var response = null;

  @override
  Widget build (BuildContext context){
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(60, 20, 60, 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage('assets/logo.png'),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Shape'.toUpperCase(),
                        style: TextStyle(fontSize: 50, color: Color.fromARGB(255, 1, 162, 235), fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'up'.toUpperCase(),
                        style: TextStyle(fontSize: 50, color: Colors.purple[700], fontWeight: FontWeight.bold),
                      ),
                    ]
                  ),
                ),
                Container(
                  height: 150,
                  child: Text(
                    'Fitness First',
                    style: TextStyle(fontSize: 55, color: Colors.black, fontFamily: 'Arial'),
                  ),
                ),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                      hintText: 'Email'),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                    hintText: 'Lozinka'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.purple[700],
                    borderRadius: BorderRadius.circular(20)),
                  child: TextButton(
                    child: Text(
                      'Prijavi se',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    onPressed: () async {
                      await Login();
                      if(HttpService.token != ''){
                        Navigator.of(context).pushReplacementNamed('/dashboard');
                      }
                      else{
                        showDialog<String>(
                          context: context, 
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('Pogreska!'),
                            content: const Text('Uneseni podaci nisu ispravni.'),
                            actions: <Widget>[
                              TextButton(onPressed: () => Navigator.pop(context, 'Ok'), child: const Text('Ok'),
                              ),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> Login() async {
    var login = LoginDto(
      email: emailController.text,
      password: passwordController.text
    );

    response = await HttpService.Post("auth/login", jsonEncode(login).toString());
    if(response == null) return;
    if(response == "500") return;
    
    if(response['token'] != null){
      HttpService.token = response['token'];
      HttpService.role = response['role'];
    }
  }

}