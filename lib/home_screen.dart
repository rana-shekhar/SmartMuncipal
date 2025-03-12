import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/auth_check.dart';
import 'package:flutter_application_1/complaint_details.dart';
import 'package:flutter_application_1/model/data.dart';
import 'package:flutter_application_1/providers/data_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCity;
  String? selectedTopic;
  bool keepAnonymous = false;
  String? selectedWard;
  // File? _imageFile;
  final picker = ImagePicker();
  String? imageUrl;

  TextEditingController addressController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  late List<String> wards;
  late List<String> cities;
  late List<String> topics;

  @override
  void initState() {
    super.initState();

    wards = context.read<DataProvider>().items;
    cities = context.read<DataProvider>().cities;
    topics = context.read<DataProvider>().topics;
  }

  // Future<void> pickImage() async {
  //   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  //   if (pickedFile != null) {
  //     setState(() {
  //       _imageFile = File(pickedFile.path);
  //     });
  //   }
  // }

  // Future<void> uploadImage() async {
  //   if (_imageFile == null) return;

  //   try {
  //     String fileName = DateTime.now().millisecondsSinceEpoch.toString();
  //     Reference storageRef = FirebaseStorage.instance
  //         .ref()
  //         .child('complaint_images/$fileName.jpg');

  //     UploadTask uploadTask = storageRef.putFile(_imageFile!);
  //     TaskSnapshot snapshot = await uploadTask;

  //     String downloadUrl = await snapshot.ref.getDownloadURL();

  //     setState(() {
  //       imageUrl = downloadUrl;
  //     });

  //     print("Image uploaded: $imageUrl");
  //   } catch (e) {
  //     print("Upload failed: $e");
  //   }
  // }

  void registerComplaint() async {
    if (formKey.currentState!.validate()) {
      if (selectedCity == null ||
          selectedWard == null ||
          addressController.text.isEmpty ||
          selectedTopic == null) {
        print("All fields are required!");
        return;
      }

      // if (_imageFile != null) {
      //   await uploadImage();
      // }

      DocumentReference docRef =
          FirebaseFirestore.instance.collection("complaints").doc();

      String complaintId = docRef.id;

      Complaint complaint = Complaint(
        id: complaintId,
        city: selectedCity ?? '',
        ward: selectedWard ?? '',
        address: addressController.text,
        topic: selectedTopic ?? '',
        description: descriptionController.text,
        // imageUrl: imageUrl,
      );
      // print('%%%%%%%%%%*********************************************$imageUrl');

      await docRef.set(complaint.toMap());

      print('Complaint Registered with ID: $complaintId');

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("🎯 Complaint Registered")),
      );

      setState(() {
        selectedCity = null;
        selectedWard = null;
        selectedTopic = null;
        addressController.clear();
        descriptionController.clear();
        // _imageFile = null;
        imageUrl = null;
      });
    }
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
                    .openEndDrawer(); // Open drawer from the right
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
                          setState(() {
                            selectedCity = value.toString();
                          });
                        },
                        validator: (value) =>
                            value == null ? "Select City" : null,
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
                          setState(() {
                            selectedWard = value.toString();
                          });
                        },
                        validator: (value) =>
                            value == null ? "Select Ward" : null,
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
                          setState(() {
                            selectedTopic = value.toString();
                          });
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
                        controller: descriptionController,
                        maxLines: 5,
                        decoration: InputDecoration(
                          labelText: 'Topic Details / Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Row(
                      //   children: [
                      //     // Image Preview
                      //     if (_imageFile != null)
                      //       ClipRRect(
                      //         borderRadius: BorderRadius.circular(10),
                      //         child: Image.file(
                      //           _imageFile!,
                      //           height: 50,
                      //           width: 50,
                      //           fit: BoxFit.cover,
                      //         ),
                      //       )
                      //     else
                      //       const Icon(Icons.image,
                      //           size: 50, color: Colors.grey),

                      //     const SizedBox(width: 10),

                      //     ElevatedButton(
                      //       onPressed: () {
                      //         if (_imageFile == null) {
                      //           pickImage();
                      //         } else {
                      //           ScaffoldMessenger.of(context).showSnackBar(
                      //             const SnackBar(
                      //               content:
                      //                   Text("You can only upload one image!"),
                      //             ),
                      //           );
                      //         }
                      //       },
                      //       style: ElevatedButton.styleFrom(
                      //         backgroundColor: Colors.blue,
                      //         padding: const EdgeInsets.symmetric(
                      //             horizontal: 16, vertical: 10),
                      //       ),
                      //       child: const Text(
                      //         'Upload Image',
                      //         style: TextStyle(color: Colors.white),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      const SizedBox(
                        height: 10,
                      ),
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
              StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("complaints")
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("No complaints found"));
                  }

                  var complaints = snapshot.data!.docs;

                  return GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: complaints.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.9,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                    ),
                    itemBuilder: (context, index) {
                      var complaintData =
                          complaints[index].data() as Map<String, dynamic>;

                      return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // Rounded corners
                        ),
                        elevation: 4, // Shadow effect
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ComplaintDetails(
                                  complaintId: complaints[index].id,
                                ),
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(15)),
                                child: Image.network(
                                  complaintData['imageUrl'] ??
                                      'https://via.placeholder.com/150', // Default image
                                  height: 100,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      complaintData['topic'] ?? 'No Topic',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87,
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_on,
                                            size: 16, color: Colors.red),
                                        const SizedBox(width: 4),
                                        Expanded(
                                          child: Text(
                                            complaintData['address'] ??
                                                'No Address',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: Colors.black54),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.home_work,
                                            size: 16, color: Colors.blue),
                                        const SizedBox(width: 4),
                                        Text(
                                          "Ward: ${complaintData['ward'] ?? 'N/A'}",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 4),
                                    Row(
                                      children: [
                                        const Icon(Icons.location_city,
                                            size: 16, color: Colors.green),
                                        const SizedBox(width: 4),
                                        Text(
                                          complaintData['city'] ?? 'No City',
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
