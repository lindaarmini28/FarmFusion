import 'package:flutter/material.dart';

class PhoneEditScreen extends StatefulWidget {
  final String currentPhone;
  final ValueChanged<String> onPhoneChanged;

  const PhoneEditScreen({
    Key? key,
    required this.currentPhone,
    required this.onPhoneChanged,
  }) : super(key: key);

  @override
  _PhoneEditScreenState createState() => _PhoneEditScreenState();
}

class _PhoneEditScreenState extends State<PhoneEditScreen> {
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController(text: widget.currentPhone);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Phone Number'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your new phone number:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              decoration: const InputDecoration(
                hintText: 'New Phone Number',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String newPhone = _phoneController.text;
                widget.onPhoneChanged(newPhone);
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
