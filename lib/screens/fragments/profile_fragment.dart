import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Laurent/controllers/client_profile_controller.dart';

class ProfileFragment extends StatelessWidget {
  final ClientProfileController clientProfileController =
  Get.put(ClientProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile/Umwirondoro'),
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
                      backgroundImage: AssetImage('assets/logo_laurent.png'),
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

                      },
                      icon: const Icon(Icons.edit,color: Colors.white),
                      label: const Text(
                        "Guhindura Umwirondoro",
                        style: TextStyle(fontSize: 16,color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 253, 112, 11),
                        textStyle: const TextStyle(fontSize: 16),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        // Navigate to change password screen
                        // Get.to(ChangePasswordScreen());
                      },
                      icon: const Icon(Icons.lock,color: Colors.white),
                      label: const Text("Hindura PIN",style: TextStyle(color: Colors.white),),
                      style: ElevatedButton.styleFrom(
                           primary: const Color.fromARGB(255, 253, 112, 11),
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
                      icon: const Icon(Icons.logout,color: Colors.white),
                      label: const Text(
                        "Sohokamo",
                        style: TextStyle(fontSize: 16,color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: const Color.fromARGB(255, 253, 112, 11),
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
