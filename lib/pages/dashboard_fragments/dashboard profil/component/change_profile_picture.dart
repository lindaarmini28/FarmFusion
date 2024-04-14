import 'package:flutter/material.dart';

class ChangeProfilePictureScreen extends StatefulWidget {
  const ChangeProfilePictureScreen({Key? key}) : super(key: key);

  @override
  _ChangeProfilePictureScreenState createState() => _ChangeProfilePictureScreenState();
}

class _ChangeProfilePictureScreenState extends State<ChangeProfilePictureScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Profile Picture'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text('This is the change profile picture page'),
          ],
        ),
      ),
    );
  }
}