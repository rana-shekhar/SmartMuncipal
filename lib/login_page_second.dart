import 'package:flutter/material.dart';

class LoginPageSecond extends StatelessWidget {
  const LoginPageSecond({super.key});

  @override
  Widget build(BuildContext context) {
     final _formKey = GlobalKey<FormState>(); // Form key banaya
    TextEditingController phoneController = TextEditingController(); // Controller Banaya
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phone Number Page',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter Phone Number',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 30),
  TextFormField(
    controller: phoneController,
    keyboardType: TextInputType.phone,
    decoration: InputDecoration(
      labelText: 'Phone Number',
      hintText: 'Enter your phone number',
      prefixIcon: const Icon(Icons.phone),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      ),
    ),
    validator: (value) {
      return validatePhoneNumber(value!);
    },
  ),
            const SizedBox(height: 30),
            Center(
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Yahan action dalna hai
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Send OTP',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
        ),
    
    );
}
String? validatePhoneNumber(String value) {
  if (value.isEmpty) {
    return 'Phone number is required';
  } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
    return 'Enter a valid 10 digit phone number';
  }
  return null; // Valid phone number hai
}
}