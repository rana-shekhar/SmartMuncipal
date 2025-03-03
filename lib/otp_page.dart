import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/home_screen.dart';

class OtpPage extends StatelessWidget {
  final String verificationId;
  const OtpPage({required this.verificationId, super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController otpController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Enter OTP', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 30),
            TextFormField(
              controller: otpController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'OTP',
                prefixIcon: const Icon(Icons.lock),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                try {
                  PhoneAuthCredential credential = PhoneAuthProvider.credential(
                    verificationId: verificationId,
                    smsCode: otpController.text,
                  );
                  await FirebaseAuth.instance.signInWithCredential(credential);
                  print("Login Successful");
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("OTP Verified")));

                  Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                } catch (e) {
                  print("Invalid OTP: \$e");
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid OTP")));
                }
              },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 50), backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
