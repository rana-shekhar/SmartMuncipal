import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/home_screen.dart';
import 'package:flutter_application_1/providers/data_provider.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_application_1/register_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  print("Firebase Connected Successfully");

 runApp(
  ChangeNotifierProvider(
    create: (context) => DataProvider(), // Yaha (context) lagana zaruri hai bhai
    child: const MyApp(),
  ),
);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Page',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:   const HomeScreen(),
    );
  }
}
