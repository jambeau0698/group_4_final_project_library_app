import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // placeholder for logo needs to be added later
            Center(
              child: Image.network(
                '',
                height: 120,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),

            const Text(
              'Welcome to our library app where our mission is provide a easy to'
                  'understand and easy to use app for libraries',
              style: TextStyle(fontSize: 16),
            ),

            const SizedBox(height: 30),

            // placeholder for map needs to be added later
            const Text(
              'Find Us Here:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),
            Container(
              height: 200,
              width: double.infinity,
              color: Colors.grey[300],
              child: const Center(child: Text('')),
            ),
          ],
        ),
      ),
    );
  }
}
