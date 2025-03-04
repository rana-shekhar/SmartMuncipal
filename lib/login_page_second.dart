import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/otp_page.dart';
import 'package:flutter_application_1/providers/data_provider.dart';
import 'package:provider/provider.dart';
import 'package:lottie/lottie.dart';

class LoginPageSecond extends StatefulWidget {
  const LoginPageSecond({super.key});

  @override
  State<LoginPageSecond> createState() => _LoginPageSecondState();
}

class _LoginPageSecondState extends State<LoginPageSecond> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    TextEditingController phoneController = TextEditingController();
    
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Phone Number Page',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Lottie.asset(
                    'assets/Animation_1741066321450.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Enter Phone Number',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixText: '+91',
                    prefixIcon: const Icon(Icons.phone),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  // validator: (value) {
                  //   if (value == null || value.isEmpty) {
                  //     return 'Phone number is required';
                  //   } else if (!RegExp(r'^[6-9]\d{9}\$').hasMatch(value)) {
                  //     return 'Enter a valid 10 digit phone number';
                  //   }
                  //   return null;
                  // },
                   validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Phone number is required';
                  } else if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                    // yeh regex sirf 10 digits ko match karega
                    return 'Enter a valid 10 digit phone number';
                  }
                  return null;
                },
                  
                ),
                const SizedBox(height: 30),
                Center(
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () async {
                        context.read<DataProvider>().updateText(phoneController.text);
                        if (formKey.currentState!.validate()) {
                          await FirebaseAuth.instance.verifyPhoneNumber(
                            phoneNumber: '+91${phoneController.text}',
                            verificationCompleted: (PhoneAuthCredential credential) {},
                            verificationFailed: (FirebaseAuthException e) {
                              print("Verification Failed: \$e");
                            },
                            codeSent: (String verificationId, int? resendToken) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => OtpPage(verificationId: verificationId,),
                                ),
                              );
                            },
                            codeAutoRetrievalTimeout: (String verificationId) {},
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                      child: const Text('Send OTP'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
