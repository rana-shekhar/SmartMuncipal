import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComplaintDetails extends StatelessWidget {
  const ComplaintDetails({super.key, required this.complaintId});
  final String complaintId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Road Construction'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('complaints')
            .doc(complaintId) // Use the passed complaintId
            .snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          var data = snapshot.data!.data() as Map<String, dynamic>;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wide Image at the Top
                Container(
                  width: double.infinity, // Take full width
                  height: 200, // Fixed height for the image
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                          data['imageUrl'] ?? 'https://picsum.photos/200/300'),
                      fit: BoxFit.cover, // Ensure the image covers the container
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Raised By : ${data['raisedBy'] ?? 'Unknown'}',
                  style: const TextStyle(
                      color: Colors.blue, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                buildDetailRow('Tracking ID', complaintId),
                buildDetailRow('Topic', data['topic'] ?? 'N/A'),
                buildDetailRow('Description', data['description'] ?? 'N/A'),
                buildDetailRow('Address', data['address'] ?? 'N/A'),
                const SizedBox(height: 10),
                const Text(
                  'Authority In Charge',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Card(
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                          data['authorityImageUrl'] ?? 'https://via.placeholder.com/50'),
                    ),
                    title: Text('MC : ${data['authorityName'] ?? 'N/A'}'),
                    subtitle: Text('${data['authorityWard'] ?? 'N/A'}'),
                    trailing: TextButton(
                      onPressed: () {},
                      child: const Text('more detail'),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildSupportCommentSection(
                        Icons.thumb_up, '${data['supports'] ?? '0'} supports'),
                    buildSupportCommentSection(
                        Icons.comment, '${data['comments'] ?? '0'} comments'),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add functionality here
                    },
                    child: const Text('Updates'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Text(value),
        ],
      ),
    );
  }

  Widget buildSupportCommentSection(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}