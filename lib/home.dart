/*
AUTHOR: ABHISHEK PATIL
PROJECT: POST API, LOGIN PAGE
for already existing gamil and password saved account

link1 fae post api for Register-successful category: https://reqres.in/api/register
link2 for fake post api:https://reqres.in/ 

*/
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Home extends StatelessWidget {
  Home({super.key});

  //----------------------------Controllers initialization
  // Creating to containers(controllers) to store user input data

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  //----------------------------
  void login(String email, String password) async {
    try {
      Response response = await post(
          Uri.parse("https://reqres.in/api/register"),
          body: {'email': email, 'password': password});

      //----------------------------getting data once we got access(or known as decoding api)
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        print(data);
        print("success");
      } else {
        print("failed");
      }

      //----------------------------
    } on Exception catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("Signup api"),
        ),

        //----------------------------body of the Looginpage
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    //color: Colors.grey,

                    borderRadius: (BorderRadius.circular(10))),
                child: TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "email",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration:
                    BoxDecoration(borderRadius: (BorderRadius.circular(10))),
                child: TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    hintText: "password",
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              //----------------------------LOGIN BUTTON
              //----------------------------CALLING THE LOGIN FUNCTION
              //----------------------------PASSING EMAIL AND PASSWORD AS ARGUEMENTS
              Container(
                height: 50,
                width: 180,
                decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: TextButton(
                  onPressed: () {
                    login(emailController.text.toString(),
                        passwordController.text.toString());
                  },
                  child: const Text("Login",
                      style: TextStyle(color: Colors.black)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
