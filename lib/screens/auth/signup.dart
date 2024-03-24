import 'dart:convert';

import 'package:Laurent/API_Connection/api_connection.dart';
import 'package:Laurent/controllers/signup_controller.dart';
import 'package:Laurent/models/client_model.dart';
import 'package:Laurent/screens/auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final SignUpController signUpController = Get.put(SignUpController());
  var namescontroller = TextEditingController();
  var emailcontroller = TextEditingController();
  var phonecontroller = TextEditingController();
  var passwordcontroller = TextEditingController();

  void cleanFields() {
    namescontroller.clear();
    emailcontroller.clear();
    phonecontroller.clear();
    passwordcontroller.clear();
  }
  bool _isRegistering = false; // Flag to track registration status
  // registration method
  storeClientMethod() async {
    setState(() {
      _isRegistering = true;
    });
    // call Client model here
    ClientModel clientModel = ClientModel(
      namescontroller.text.trim(),
      emailcontroller.text.trim(),
      phonecontroller.text.trim(),
      passwordcontroller.text.trim(),
    );

  //   try and again
    try{

      var url = API.signup;
      var csrfToken = '';
      print(url);
      var res = await http.post(Uri.parse(url),body: clientModel.toJson());
      // print("response data: ${res.body}");
      // print("status code : ${res.statusCode}");
      var data = jsonDecode(res.body);
      String message1 = data['message'];
        if(message1.contains('Error')){
          Get.snackbar("Message", data['message'],
              snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,colorText: Colors.white);
        }else{
          Get.snackbar("Message1", data['message'],
              snackPosition: SnackPosition.BOTTOM,duration: Duration(seconds: 3),
            backgroundColor: Colors.green,
          colorText: Colors.white);
        }
      if (res.statusCode == 201) {
        //get response data
        var data = jsonDecode(res.body);
        var status = data['status'];
        var message = data['message'];
        if (message == "successfully") {
          Get.snackbar("Message", message + "Konti Yafunguwe neza",
              snackPosition: SnackPosition.BOTTOM,duration: Duration(seconds: 3),
            backgroundColor: Colors.green,colorText: Colors.white);
          cleanFields();
        } else {
          Get.snackbar("Error", "Konti Ntiyafunguwe neza",
              snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,colorText: Colors.white,
          );
          // Get.to(LoginFragment());
        }

      } else {
        print(res);
      }
      Future.delayed(Duration(seconds: 3), () {
        // After registration completes
        setState(() {
          _isRegistering = false; // Set flag to false when registration completes
        });
      });

    }catch(e){

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up/Iyandikishe'),
        backgroundColor: const Color.fromARGB(255, 253, 112, 11),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset(
                'assets/logo_laurent.png',
                width: 100,
                height: 100,
              ),
              const SizedBox(
                height: 20,
              ),
              _buildNameTextField(),
              const SizedBox(
                height: 20,
              ),
              _buildPhoneNumberTextField(),
              const SizedBox(
                height: 20,
              ),
              _buildEmailTextField(),
              const SizedBox(
                height: 20,
              ),
              _buildPasswordTextField(),
              const SizedBox(
                height: 20.0,
              ),
              _buildSignUpButton(),
              const SizedBox(
                height: 20.0,
              ),
              TextButton(
            onPressed: () {
              Get.offAll(LoginScreen());
            },
            child: const Text('Ufite Konti? kanda Kwinjira'),
          ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNameTextField() {
    return TextFormField(
      controller: namescontroller,
      decoration: const InputDecoration(
        labelText: 'Names/ Amazina',
        prefixIcon: Icon(Icons.person),
      ),
      keyboardType: TextInputType.text,
    );
  }

  Widget _buildPhoneNumberTextField() {
    return TextFormField(
      controller: phonecontroller,
      decoration: const InputDecoration(
        labelText: 'Phone Number/Numero ya telefone',
        prefixIcon: Icon(Icons.phone),
      ),
      keyboardType: TextInputType.phone,
    );
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      controller: emailcontroller,
      decoration: const InputDecoration(
        labelText: 'Email',
        prefixIcon: Icon(Icons.email),
      ),
      keyboardType: TextInputType.emailAddress,
    );
  }

  Widget _buildPasswordTextField() {
    return Obx(() {
      return TextFormField(
        controller: passwordcontroller,
        obscureText: !signUpController.isPasswordVisible.value,
        decoration: InputDecoration(
          labelText: 'Password/Mot de passe',
          prefixIcon: const Icon(Icons.lock),
          suffixIcon: IconButton(
            icon: const Icon(Icons.visibility),
            onPressed: () {
              signUpController.togglePasswordVisibility();
            },
          ),
        ),
      );
    });
  }

  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: () {
        // Implement sign up logic
        storeClientMethod();
      },
      child: _isRegistering ? CircularProgressIndicator() : const Text('Sign Up/Iyandikishe'),
    );
  }
}
