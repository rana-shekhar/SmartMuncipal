import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/login_page_second.dart';
import 'package:flutter_application_1/register_page.dart';

class AuthCheck extends StatefulWidget {
  const AuthCheck({super.key});

  @override
  State<AuthCheck> createState() => AuthCheckState();
}

class AuthCheckState extends State<AuthCheck> {
  @override
  void initState() {
    super.initState();
     WidgetsBinding.instance.addPostFrameCallback((_) {
    authCheck();
  });
  }

  void authCheck() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var userDoc = await FirebaseFirestore.instance
            .collection("users")
            .where('phone', isEqualTo: user.phoneNumber)
            .get();

        if (userDoc.docs.isNotEmpty) {
          debugPrint("User Already Registered ✅");
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Welcome Back!")),
            );
            Navigator.pushAndRemoveUntil(
                context, MaterialPageRoute(builder: (context) => const HomeScreen()), (route) => false);
          }
        } else {
          debugPrint("New User 🔥");
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Proceed to Registration")),
            );
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const RegistrationScreen()));
          }
        }
      } else {
        if (mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const LoginPageSecond()));
        }
      }
    } catch (e) {
      debugPrint("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
   
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
