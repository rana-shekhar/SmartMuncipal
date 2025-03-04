// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/model/data.dart';
import 'package:flutter_application_1/providers/data_provider.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {


  const RegistrationScreen({super.key});
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  String? selectedWard;

  @override
  void initState() {
    super.initState();
    phoneController.text;
  }

  void registerUser() async {
    print(
        "User registered****************************************************************UUUUUUUUUUUUUUUUU: ${nameController.text}");

    if (_formKey.currentState!.validate()) {
      UserModel user = UserModel(
        name: nameController.text,
        phone: phoneController.text,
        state: stateController.text,
        city: cityController.text,
        address: addressController.text,
        ward: selectedWard,
      );

      await FirebaseFirestore.instance.collection("users").add(user.toMap());

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("🎯 Registration Successful")),
      );

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("🎉 Hurray!"),
            content: const Text("You're now registered 🥳"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );

      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
   phoneController.text =  '+91${context.read<DataProvider>().text}';
    final List<String> wards = context.read<DataProvider>().items;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration"),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: "Your Name",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Enter your name" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller:  phoneController,
                enabled: false,
                decoration: const InputDecoration(
                  labelText: "Phone Number",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: stateController,
                decoration: const InputDecoration(
                  labelText: "State",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Enter State" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: cityController,
                decoration: const InputDecoration(
                  labelText: "City",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Enter City" : null,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: addressController,
                decoration: const InputDecoration(
                  labelText: "Address",
                  border: OutlineInputBorder(),
                ),
                validator: (value) => value!.isEmpty ? "Enter Address" : null,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: selectedWard,
                items: wards
                    .map((ward) =>
                        DropdownMenuItem(value: ward, child: Text(ward)))
                    .toList(),
                decoration: const InputDecoration(
                  labelText: "Select Ward No.",
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) => setState(() => selectedWard = value),
                validator: (value) => value == null ? "Select Ward" : null,
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: registerUser,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
