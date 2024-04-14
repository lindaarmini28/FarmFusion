import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Us'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Farm Fusion',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            const Text(
              'Description',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text(
              'Farm Fusion is a platform that connects farmers and merchants to optimize the marketing of harvests through a contract system. Our mission is to revolutionize agricultural trading by providing a seamless and transparent marketplace for both farmers and merchants.',
            ),
            const SizedBox(height: 20),
            const Text(
              'Contact Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildContactItem(
              icon: Icons.email,
              label: 'Email',
              value: 'info@farmfusion.com',
            ),
            _buildContactItem(
              icon: Icons.phone,
              label: 'Phone',
              value: '+1234567890',
            ),
            const SizedBox(height: 20),
            const Text(
              'Follow Us',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              
              
              children: [
              Tab(icon: Image.asset("assets/images/facebook.png")),
              const SizedBox (width: 10),
              Tab(icon: Image.asset("assets/images/twitter.png")),
              const SizedBox (width: 10),
              Tab(icon: Image.asset("assets/images/github.png")),
            ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactItem({IconData icon = Icons.info, String label = '', String value = ''}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      subtitle: Text(value),
      onTap: () {
        // Implement action for contacting support
      },
    );
  }

  // Widget _buildSocialMediaIcon({IconData icon = Icons.info, VoidCallback onPressed()}) {
  //   return IconButton(
  //     icon: Icon(icon),
  //     onPressed: onPressed,
  //   );
  // }
}
