import 'package:flutter/material.dart';
import 'package:flutterwave_standard/flutterwave.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';


class PayFlutterWave extends StatefulWidget {
  const PayFlutterWave({super.key});

  @override
  State<PayFlutterWave> createState() => _PayFlutterWaveState();
}

class _PayFlutterWaveState extends State<PayFlutterWave> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pay'),
      ),
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 8.0,),
            TextButton(
              onPressed: () {
                handlePaymentInitialization() async {
                  final Customer customer = Customer(
                      name: "Enock Developer",
                      phoneNumber: "0783982872",
                      email: "customer@customer.com"
                  );
                  final Flutterwave flutterwave = Flutterwave(
                      context: context, publicKey: "FLWPUBK-0c8f309650b1bb8c2db8a703ab332b6d-X",
                      currency: "RWF",
                      redirectUrl: "https://nigoote.com",
                      txRef: Uuid().v4(),
                      amount: "100",
                      customer: customer,
                      paymentOptions: "ussd, card, mobilemoneyrwanda",
                      customization: Customization(title: "My Payment"),
                      isTestMode: false );
                  final ChargeResponse response = await flutterwave.charge();
                  // this.showLoading(response.toString());
                  print("enock_data:${response.toJson()}");
                  print('Status: ${response.status}');

                  print('Success: ${response.success}');
                  print('Transaction ID: ${response.transactionId}');
                  print('Tx Ref: ${response.txRef}');
                }
                handlePaymentInitialization();
              },
              child: const Text(
                'Pay',
                style: TextStyle(fontSize: 16.0,color: Colors.blue,),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
