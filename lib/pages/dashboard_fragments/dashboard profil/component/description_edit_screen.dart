import 'package:flutter/material.dart';

class DescriptionEditScreen extends StatefulWidget {
  final String currentDescription;
  final ValueChanged<String> onDescriptionChanged;

  const DescriptionEditScreen({
    Key? key,
    required this.currentDescription,
    required this.onDescriptionChanged,
  }) : super(key: key);

  @override
  _DescriptionEditScreenState createState() => _DescriptionEditScreenState();
}

class _DescriptionEditScreenState extends State<DescriptionEditScreen> {
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _descriptionController =
        TextEditingController(text: widget.currentDescription);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Description'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Enter your new description:',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _descriptionController,
              maxLines: null,
              decoration: const InputDecoration(
                hintText: 'New Description',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String newDescription = _descriptionController.text;
                widget.onDescriptionChanged(newDescription);
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
