// import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_check.dart';
import 'package:flutter_application_1/complaint_details.dart';
import 'package:flutter_application_1/model/data.dart';
import 'package:flutter_application_1/providers/data_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String?selectedCity;

  String? selectedTopic;
  bool keepAnonymous = false;
  String? selectedWard;

  TextEditingController cityController = TextEditingController();
  TextEditingController wardController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController topicController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void registerComplaint() async {
    if (formKey.currentState!.validate()) {
      Complaint complaint = Complaint(
        city: selectedCity ?? '',
        ward: selectedWard ?? '',
        address: addressController.text,
        topic: selectedTopic ?? '',
        description: descriptionController.text,
      );
      print('Complaint: ***************************************${complaint.toMap()}');
      await FirebaseFirestore.instance
          .collection("complaints")
          .add(complaint.toMap());
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("🎯 Complaint Registered")),
      );
    }
  }

  late List<String> wards;
  late List<String> cities;
  late List<String> topics;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wards = context.read<DataProvider>().items;
    cities = context.read<DataProvider>().cities;
    topics = context.read<DataProvider>().topics;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blue,
        title:
            const Text('Welcome, User', style: TextStyle(color: Colors.white)),
        actions: [
          const IconButton(
            onPressed: null,
            icon: Icon(Icons.notifications, color: Colors.white),
          ),
          const SizedBox(width: 20),
          Builder(
            builder: (context) => IconButton(
              onPressed: () {
                Scaffold.of(context)
                    .openEndDrawer(); // Left se drawer open hoga
              },
              icon: const Icon(Icons.settings, color: Colors.white),
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Settings Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const AuthCheck()));
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'MC'),
          BottomNavigationBarItem(
              icon: Icon(Icons.report), label: 'Complaints'),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    const ListTile(
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://via.placeholder.com/150'),
                      ),
                      title: Text('MC - Mr.Anil Jain',
                          style: TextStyle(color: Colors.white)),
                      subtitle: Text(
                        'Address: H.no.00 ABC Street, Hisar Haryana 125001 Contact No.: +91-XXXXXXXXXX',
                        style: TextStyle(color: Colors.white70),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10),
                      child: Column(
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.phone, color: Colors.black),
                            label: const Text('Call now',
                                style: TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            child: const Text('View Details',
                                style: TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text('Complaint, Here',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      DropdownButtonFormField(
                        value: selectedCity,
                        items: cities.map((city) {
                          return DropdownMenuItem(
                              value: city, child: Text(city));
                        }).toList(),
                        onChanged: (value) {
                          selectedCity = value.toString();
                        },
                        validator: (value) =>
                            value == null ? "Select Topic" : null,
                        decoration: InputDecoration(
                            labelText: 'Select City',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                        value: selectedWard,
                        items: wards.map((ward) {
                          return DropdownMenuItem(
                              value: ward, child: Text(ward));
                        }).toList(),
                        onChanged: (value) {
                          selectedWard = value.toString();
                        },
                        validator: (value) =>
                            value == null ? "Select Topic" : null,
                        decoration: InputDecoration(
                            labelText: 'Select Ward no.',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10))),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        controller: addressController,
                        decoration: InputDecoration(
                          labelText: 'Enter the address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      DropdownButtonFormField(
                        borderRadius: BorderRadius.circular(10),
                        value: selectedTopic,
                        items: topics.map((topic) {
                          return DropdownMenuItem(
                              value: topic, child: Text(topic));
                        }).toList(),
                        onChanged: (value) {
                          selectedTopic = value.toString();
                        },
                        validator: (value) =>
                            value == null ? "Select Topic" : null,
                        decoration: InputDecoration(
                            labelText: 'Select Topic',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            )),
                      ),
                      const SizedBox(height: 10),
                      TextField(
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Topic Details / Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      // Row(
                      //   children: [
                      //     Checkbox(
                      //       value: keepAnonymous,
                      //       onChanged: (value) {
                      //         keepAnonymous = value!;
                      //       },
                      //     ),
                      //     const Text('Keep Anonymous'),
                      //   ],
                      // ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: registerComplaint,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Raise Complaint',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text('My Complaints',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Align(
                alignment: Alignment.topRight,
                child:
                    TextButton(onPressed: () {}, child: const Text('view all')),
              ),
           
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.8,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ComplaintDetails(),
                          ),
                        );
                      },
                      child: Column(
                        children: [
                          Image.network(
                            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEzuF76aExMemVM_FESKsa3aPmFmusr8ApFw&s',
                            height: 100,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          const Expanded(
                            child: ListTile(
                              title: Text('Road Damage'),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('shubham'),
                                  Text('Ward no.2'),
                                  Text('In-Progress'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
