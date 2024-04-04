import 'dart:convert';
import 'dart:ffi';

import 'package:Laurent/API_Connection/api_connection.dart';
import 'package:Laurent/controllers/subscription_controller.dart';
import 'package:Laurent/screens/auth/login.dart';
import 'package:Laurent/screens/fragments/home_fragment.dart';
import 'package:Laurent/screens/fragments/main_fragment.dart';
import 'package:Laurent/screens/fragments/sample_page.dart';
import 'package:flutter/material.dart';
import 'package:flutterwave_standard/core/flutterwave.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class BeforeLoginSubscriptionFragment extends StatelessWidget {
  final SubscriptionController subscriptionController =
      Get.put(SubscriptionController());
  @override
  Widget build(BuildContext context) {
    Future<void> storeTransaction(clientId,amount,status,transactionId,txRef,subscriptionsId) async {
      // Define the URL where your Laravel API is hosted
      final String apiUrl = API.makePayment;
      try {

        // Make a POST request to store the transaction data
        final http.Response response = await http.post(
          Uri.parse(apiUrl),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, dynamic>{
            'amount': amount,
            'clientId': clientId,
            'subscriptionsId': subscriptionsId,
            'transactionId': transactionId,
            'txRef': txRef,
            'status':status,
          }),
        );
        var data = json.decode(response.body);
        if (response.statusCode == 200) {
          print(data['message']);
            Get.snackbar(
              'Ubutumwa',
              data['message'],
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
        } else {
          print(data['message']);
            Get.snackbar(
              'Ubutumwa',
              data['message'],
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          print('Failed to store transaction. Status code: ${response.statusCode}');
          print('Response body: ${response.body}');
        }
      } catch (e) {
        print('Error storing transaction: $e');
      }
    }



    handlePaymentInitialization(amount,description,subscriptionId) async {
      SharedPreferences shPre = await SharedPreferences.getInstance();
      var myId = await shPre.getInt('id');
      var names = await shPre.getString('names');
      var phone_number = await shPre.getString('phone_number');
      var email = await shPre.getString('email');

      // var amount = 100;
      final Customer customer = Customer(
        email: '$email',
        name: '$names',
        phoneNumber: '$phone_number',
      );
      final Flutterwave flutterwave = Flutterwave(
          context: context,
          publicKey: 'FLWPUBK-0c8f309650b1bb8c2db8a703ab332b6d-X',
          currency: 'RWF',
          redirectUrl: 'https://nigoote.com',
          txRef: Uuid().v4(),
          amount: '$amount',
          customer: customer,
          paymentOptions: "card,mobilemoneyrwanda",
          customization: Customization(title: description),
          isTestMode: false);
      final ChargeResponse response = await flutterwave.charge();
      // this.showLoading(response.toString());
      print("enock_data:${response.toJson()}");
      print('Status: ${response.status}');

      print('Success: ${response.success}');
      print('Transaction ID: ${response.transactionId}');
      print('Tx Ref: ${response.txRef}');
      //   data from response flutterwave
      var status = response.status;
      var success = response.success;
      var transactionId = response.transactionId;
      var txRef = response.txRef;
      //   savePayment in db
      if(status=='error' || success== false){
        Get.snackbar(
          'Ubutumwa',
          'Harimo Ikibazo Mu Kwishyura Mongere Mugerageze',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }else{
        storeTransaction(myId, amount, status, transactionId, txRef,subscriptionId);
      }

    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Ifatabuguzi',style: TextStyle(
          color: Colors.white,
        )),
        backgroundColor: const Color.fromARGB(255, 253, 112, 11),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Obx(() {
          if (subscriptionController.isLoading.value) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: subscriptionController.subscriptionsModel.length,
              itemBuilder: (context, index) {
                var subscription = subscriptionController.subscriptionsModel[index];
                return Card(
                  elevation: 4.0,
                  child: ListTile(
                    leading: Icon(Icons.access_time),
                    title: Text(subscription.title),
                    subtitle: Text(subscription.details),
                    trailing: Text(subscription.price),
                    onTap: () {
                      var subId = subscription.id;
                      var price = subscription.price;
                      var title = subscription.title;
                      var subscriptionId = subscription.id;


                      //   check subscription method
                      void checkSubcription(subId) async {
                        SharedPreferences shPre = await SharedPreferences.getInstance();
                        var clientId = await shPre.getInt('id');
                        var url = API.checkSubscription;
                        // print("chechsubscription of $subId on $url link");
                        try {
                          final response = await http.post(
                            Uri.parse(url),
                            body: jsonEncode({
                              'subscriptionId': subId,
                              'clientId': clientId,
                            }),
                            headers: {
                              'Content-Type': 'application/json',
                            },
                          );
                          print('data1: ${response.body}');
                          var data = json.decode(response.body);
                          var message = data['message'];
                          if (response.statusCode == 200) {
                            print(message);

                            Get.snackbar(
                                'Ubutumwa',
                                '$message \ Ifarabuguzi Ubu riracyari Gukoreshwa',
                                snackPosition: SnackPosition.BOTTOM,
                                backgroundColor: Colors.red,
                                colorText: Colors.white
                            );

                          } else if (response.statusCode == 404) {
                            Get.snackbar(
                                'Ubutumwa',
                                'Ubu Gukomeza Kwishyura Birakunda',
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: Colors.green,
                                colorText: Colors.white
                            );
                            handlePaymentInitialization(price,title,subscriptionId);
                          } else {
                            print('Failed to check subscription status');
                          }
                        } catch (error) {
                          print('error from catch $error');
                        }
                      }
                      checkSubcription(subId);
                    },
                  ),
                );
              },
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // clientProfileController.fetchClientData();
          subscriptionController.fetchSubscriptions();
        },
        backgroundColor: const Color.fromARGB(255, 253, 112, 11),
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}
