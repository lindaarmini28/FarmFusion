import 'package:flutter/material.dart';

class HelpCenterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help Center'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildFAQItem(
              question: 'How do I create an account?',
              answer: 'To create an account, click on the "Sign Up" button and follow the instructions.',
            ),
            _buildFAQItem(
              question: 'How do I reset my password?',
              answer: 'To reset your password, go to the login page and click on "Forgot Password". Follow the instructions sent to your email.',
            ),
            const SizedBox(height: 30),
            const Text(
              'Contact Support',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            _buildContactItem(
              icon: Icons.email,
              label: 'Email',
              value: 'support@farmfusion.com',
            ),
            _buildContactItem(
              icon: Icons.phone,
              label: 'Phone',
              value: '+1234567890',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem({String question = '', String answer = ''}) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(answer),
        ),
      ],
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
}
