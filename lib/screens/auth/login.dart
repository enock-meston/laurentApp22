import 'dart:developer';

import 'package:Laurent/API_Connection/api_connection.dart';
import 'package:Laurent/controllers/login_controller.dart';
import 'package:Laurent/screens/auth/signup.dart';
import 'package:Laurent/screens/fragments/before_login_subscription_fragment.dart';
import 'package:Laurent/screens/fragments/main_fragment.dart';
import 'package:Laurent/screens/fragments/pay_flutterwave.dart';
import 'package:Laurent/screens/fragments/subscription_fragment.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController loginController = Get.put(LoginController());
  var formKey = GlobalKey<FormState>();
  //text field controllers
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();
  bool _isRegistering = false; // Flag to track registration status

  // login method
  Future<void> loginMethod() async {
    SharedPreferences sPreferences = await SharedPreferences.getInstance();

    setState(() {
      _isRegistering = true;
    });

    // initialize phone and password
    var phoneTxt = phoneController.text;
    var passwordTxt = passwordController.text;
    // use try and catch to handle errors
    try {
      var url = Uri.parse(API.login);
      // send data to server
      var response = await http.post(url, body: {
        "phone_number": phoneTxt,
        "password": passwordTxt,
      });
      print("response.body: ${response.body}");
      var data1 = jsonDecode(response.body);
      var message1 = data1['message'];
      // print('message 1:'+ message1);
      if(message1.contains('Invalid credentials')){
        Get.snackbar("Ubutumwa", "Amakuru Mwatanze Siyo!",
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
      }else if(message1.contains('Iminsi yifarabuguzi rarashize')){
        var data = jsonDecode(response.body);
        // check message from data
        var id =await sPreferences.setInt("id",data['client']['id']);
        // var names = await sPreferences.setString('key', 'Enock');
        var names =await sPreferences.setString("names",data['client']['names']);
        var phone =await sPreferences.setString("phone_number",data['client']['phone_number']);
        var email =await sPreferences.setString("email",data['client']['email']);
        var status =await sPreferences.setString("status",data['client']['status']);
        Get.snackbar("Ubutumwa", message1,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        Get.offAll(BeforeLoginSubscriptionFragment());
      }
      else if(message1.contains('Banza Wishyure')){
        var data = jsonDecode(response.body);
        // check message from data
        var id =await sPreferences.setInt("id",data['client']['id']);
        // var names = await sPreferences.setString('key', 'Enock');
        var names =await sPreferences.setString("names",data['client']['names']);
        var phone =await sPreferences.setString("phone_number",data['client']['phone_number']);
        var email =await sPreferences.setString("email",data['client']['email']);
        var status =await sPreferences.setString("status",data['client']['status']);
        Get.snackbar("Ubutumwa", message1,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        Get.offAll(BeforeLoginSubscriptionFragment());
      }else if(message1.contains('ifatabuguzi ryararangiye')){
        var data = jsonDecode(response.body);
        // check message from data
        var id =await sPreferences.setInt("id",data['client']['id']);
        // var names = await sPreferences.setString('key', 'Enock');
        var names =await sPreferences.setString("names",data['client']['names']);
        var phone =await sPreferences.setString("phone_number",data['client']['phone_number']);
        var email =await sPreferences.setString("email",data['client']['email']);
        var status =await sPreferences.setString("status",data['client']['status']);

        Get.snackbar("Ubutumwa", message1,
            snackPosition: SnackPosition.BOTTOM,
            backgroundColor: Colors.red,
            colorText: Colors.white);
        Get.offAll(BeforeLoginSubscriptionFragment());
      }
      else if (response.statusCode == 200) {

        var data = jsonDecode(response.body);
        // check message from data
        var id =await sPreferences.setInt("id",data['client']['id']);
        // var names = await sPreferences.setString('key', 'Enock');
        var names =await sPreferences.setString("names",data['client']['names']);
        var phone =await sPreferences.setString("phone_number",data['client']['phone_number']);
        var email =await sPreferences.setString("email",data['client']['email']);
        var status =await sPreferences.setString("status",data['client']['status']);
        // String n = data['client']['names'];
        // check if your subscription
        String? stringValue = sPreferences.getString('names');
        print('Retrieved String: $stringValue');
          Get.snackbar("Ubutumwa", "Kwijira byagenze neza!",
              snackPosition: SnackPosition.BOTTOM,
              backgroundColor: Colors.green,
              colorText: Colors.white);
        Get.back();
        Get.offAll(() => MainFragment());

        //end check if your subscription
      }
      Future.delayed(Duration(seconds: 3), () {
        // After registration completes
        setState(() {
          _isRegistering = false; // Set flag to false when registration completes
        });
      });
    }catch(e){
     log("---$e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: const Text('Login/Kwinjira'),
        // backgroundColor: const Color.fromARGB(255, 253, 112, 11),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
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
                TextFormField(
                  controller: phoneController,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  keyboardType: TextInputType.phone,
                  // Add your validation logic if needed
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() {
                  return TextFormField(
                    controller: passwordController,
                    obscureText: !loginController.isPasswordVisible.value,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.visibility),
                        onPressed: () {
                          loginController.togglePasswordVisibility();
                        },
                      ),
                    ),
                  );
                }),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    // login method
                    // Get.to(mainFragment());
                    if (formKey.currentState!.validate()) {
                      print("Validated");
                      loginMethod();
                      // loading dialog if login is processing
                      //loading dialog if login is processing
                      // Get.defaultDialog(
                      //   title: "Kwinjira",
                      //   content: CircularProgressIndicator(),
                      //   barrierDismissible: false,
                      // );
                    }
                  },
                  child: _isRegistering ? CircularProgressIndicator() :const Text('Login/Injira'),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                //new account link
                TextButton(
                  onPressed: () {
                    Get.to(SignUpScreen());
                  },
                  child: const Text(
                    'new Account/ kora konti',
                    style: TextStyle(fontSize: 16.0,color: Colors.blue,),
                  ),
                ),
                const SizedBox(height: 8.0,),
                TextButton(
                  onPressed: () {
                    Get.to(SignUpScreen());
                  },
                  child: const Text(
                    'Forget Password?\n Wibagiwe Ijambo Banga',
                    style: TextStyle(fontSize: 16.0,color: Colors.blue,),
                    textAlign: TextAlign.center,
                  ),
                ),

                const SizedBox(height: 8.0,),
                // TextButton(
                //   onPressed: () {
                //     Get.to(PayFlutterWave());
                //   },
                //   child: const Text(
                //     'ishyura',
                //     style: TextStyle(fontSize: 16.0,color: Colors.blue,),
                //     textAlign: TextAlign.center,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
