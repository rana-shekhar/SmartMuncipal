import 'package:flutter/material.dart';
import 'package:flutter_application_1/complaint_details.dart';
import 'package:flutter_application_1/providers/data_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  // final _cities = ['Select City', 'Hisar', 'Delhi', 'Mumbai'];
  // final _wards = ['Select Ward no.', 'Ward 1', 'Ward 2', 'Ward 3'];
  // final _topics = [
  //   'Select Topic',
  //   'Road Damage',
  //   'Garbage Issue',
  //   'Water Problem'
  // ];

  @override
  Widget build(BuildContext context) {
    String? selectedCity;

    String? selectedTopic;
    bool keepAnonymous = false;
    String? selectedWard;
    final List<String> wards = context.read<DataProvider>().items;
    final List<String> _cities = context.read<DataProvider>().cities;
    final List<String> _topics = context.read<DataProvider>().topics;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF0A8EA0),
        title:
            const Text('Welcome, User', style: TextStyle(color: Colors.white)),
        actions: const [
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 20),
          Icon(Icons.settings, color: Colors.white),
          SizedBox(width: 20),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF0A8EA0),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'MC'),
          BottomNavigationBarItem(
              icon: Icon(Icons.report), label: 'Complaints'),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              color: const Color(0xFF0A8EA0),
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
                          child: const Text('View Details',
                              style: TextStyle(color: Colors.black)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                          ),
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
                      items: _cities.map((city) {
                        return DropdownMenuItem(value: city, child: Text(city));
                      }).toList(),
                      onChanged: (value) {},
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
                        return DropdownMenuItem(value: ward, child: Text(ward));
                      }).toList(),
                      onChanged: (value) {},
                      decoration:
                          InputDecoration(labelText: 'Select Ward no.',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10))),  
                    ),
                    const SizedBox(height: 10),
                    TextField(
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
                      items: _topics.map((topic) {
                        return DropdownMenuItem(
                            value: topic, child: Text(topic));
                      }).toList(),
                      onChanged: (value) {},
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
                    Row(
                      children: [
                        Checkbox(
                          value: keepAnonymous,
                          onChanged: (value) {},
                        ),
                        const Text('Keep Anonymous'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text('Raise Complaint'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0A8EA0),
                        minimumSize: const Size(double.infinity, 50),
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
                          'https://via.placeholder.com/150',
                          height: 100,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                        const ListTile(
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
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
