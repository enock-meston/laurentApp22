import 'dart:convert';

import 'package:Laurent/API_Connection/api_connection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Laurent/controllers/client_profile_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
class ProfileFragment extends StatelessWidget {
  final ClientProfileController clientProfileController =
  Get.put(ClientProfileController());

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController NewPasswordController = TextEditingController();


  Future<void> changePassword(BuildContext context) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var myId = await sharedPreferences.getInt('id');

    String currentPassword = currentPasswordController.text;
    String newPassword = NewPasswordController.text;

    print('pass: $currentPassword = $newPassword');
    // Replace this URL with your server endpoint for changing password
    final String apiUrl = API.changePassword;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
          // If you need authorization header, you can add it here
          // 'Authorization': 'Bearer $accessToken',
        },
        body: jsonEncode({
          'current_password': currentPassword,
          'new_password': newPassword,
          'clientId': myId,
        }),
      );
  var data = jsonDecode(response.body);
      if (response.statusCode == 200) {
        // Password changed successfully
        print('Password changed successfully');
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Password changed successfully'),
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        // Failed to change password
        print('Failed to change password. Error: ${response.body}');
        Navigator.of(context).pop();
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(data['message']),
              duration: Duration(seconds: 2),
            ));
      }
    } catch (error) {
      print('Error while changing password: $error');
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$error'),
            duration: Duration(seconds: 2),
          ));
    }
  }

  // Method to show the comment dialog
  void _showCommentDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CommentDialog(); // Defined below
      },
    );
  }

  // change password
  // Method to show the change password dialog
  void _showChangePasswordDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Hindura PIN'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                obscureText: true,
                controller: currentPasswordController,
                decoration: InputDecoration(labelText: 'PIN Isazwe'),
              ),
              TextField(
                obscureText: true,
                controller: NewPasswordController,
                decoration: InputDecoration(labelText: 'PIN Shyashya'),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // Call method to change password
                // _changePassword(context);
                changePassword(context);
              },
              child: Text('Hindura'),
            ),
          ],
        );
      },
    );
  }
  // ==============

  // ==================
  // Method to change the password
  void _changePassword(BuildContext context) {

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Password changed successfully'),
        duration: Duration(seconds: 2),
      ),
    );

  }
  // ==================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile/Umwirondoro',style: TextStyle(color: Colors.white,),),
        backgroundColor:const Color.fromARGB(255, 253, 112, 11),
        actions: [
          IconButton(
            icon: Icon(Icons.comment,),
            tooltip: 'Ubutumwa',
            onPressed: () {
              // Show the comment dialog
              _showCommentDialog(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Obx(
                () {
              if (clientProfileController.clientProfile.value.id == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const CircleAvatar(
                      radius: 60,
                      backgroundImage:
                      AssetImage('assets/logo_laurent.png'),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Full Name:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${clientProfileController.clientProfile.value.names}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Email:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${clientProfileController.clientProfile.value.email}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Phone:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${clientProfileController.clientProfile.value.phoneNumber}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Get.to(ChangePasswordScreen());
                        // Show the change password dialog
                        _showChangePasswordDialog(context);

                      },
                      icon: const Icon(Icons.lock, color: Colors.white),
                      label: const Text(
                        "Hindura PIN",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 253, 112, 11),
                        textStyle: const TextStyle(fontSize: 16),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                        clientProfileController.signOutUser();
                      },
                      icon: const Icon(Icons.logout, color: Colors.white),
                      label: const Text(
                        "Sohokamo",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 253, 112, 11),
                        textStyle: const TextStyle(fontSize: 16),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          clientProfileController.fetchClientData();
        },
        backgroundColor: const Color.fromARGB(255, 253, 112, 11),
        child: const Icon(Icons.refresh, color: Colors.white),
      ),
    );
  }
}

class CommentDialog extends StatefulWidget {
  @override
  _CommentDialogState createState() => _CommentDialogState();
}

class _CommentDialogState extends State<CommentDialog> {
  TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Ohereza Icyifuzozo'),
      content: TextField(
        controller: _commentController,
          maxLines: null, // Allows for multiline input
          decoration: InputDecoration(
            hintText: 'Enter your comment here',
            contentPadding: EdgeInsets.all(10.0), // Adjust content padding
            border: OutlineInputBorder(), // Add border around the input area
          )
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            // Send the comment (you can implement sending logic here)
            String comment = _commentController.text;
            // print('Comment: $comment');
            sendComentMethod(comment);
            // Navigator.of(context).pop(); // Close the dialog
          },
          child: Text('Send'),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void sendComentMethod(String comment) async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var myId = await sharedPreferences.getInt('id');
    try{
      var url = API.comment;
      var requestBody = {'comment': comment, 'clientId': myId.toString()};

      var response = await http.post(Uri.parse(url), body: requestBody);
      final data = json.decode(response.body); // yes cool

      if (response.statusCode == 200) {
        // final jsonData = json.decode(response.body)['comment']; // yes cool
        // print('data: $data');
        Get.snackbar("Message", data['message'],
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
            backgroundColor: Colors.green,colorText: Colors.white);
        Navigator.of(context).pop();
      } else {
        // Handle other status codes (e.g., error)
        print('Error: ${response.statusCode}');
        Get.snackbar("Message", data['message'],
            snackPosition: SnackPosition.BOTTOM,
            duration: Duration(seconds: 3),
            backgroundColor: Colors.red,colorText: Colors.white);
        Navigator.of(context).pop();
      }
    }catch(e){
      // Handle any exceptions
      print('Error: $e');
      Get.snackbar("Error", '$e',
          snackPosition: SnackPosition.BOTTOM,
          duration: Duration(seconds: 3),
          backgroundColor: Colors.red,colorText: Colors.white);
    }
  }


}
