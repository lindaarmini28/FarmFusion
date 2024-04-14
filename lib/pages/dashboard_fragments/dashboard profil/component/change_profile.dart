import 'package:flutter/material.dart';
import '../component/change_profile_picture.dart';
import '../component/name_edit_screen.dart';
import '../component/phone_edit_screen.dart';
import '../component/description_edit_screen.dart';
import '../component/email_edit_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String name = 'Linda Armini';
  String phone = '087755778819';
  String email = 'lindaarmini28@gmail.com';
  String description =
      'Saudagar Padi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Change Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const CircleAvatar(
                      radius: 50,
                      backgroundImage:
                          AssetImage('assets/images/profile.png'),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ChangeProfilePictureScreen()),
                        );
                      },
                      icon: const Icon(Icons.edit, color: Colors.white),
                      label: const Text('Change Profile Picture', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(183, 2, 93, 58),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Name
              buildEditableItem(name, 'Name', Icons.person, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NameEditScreen(
                      currentName: name,
                      onNameChanged: (newName) {
                        setState(() {
                          name = newName;
                        });
                      },
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              // Phone
              buildEditableItem(phone, 'Phone', Icons.phone, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PhoneEditScreen(
                      currentPhone: phone,
                      onPhoneChanged: (newPhone) {
                        setState(() {
                          phone = newPhone;
                        });
                      },
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              // Email
              buildEditableItem(email, 'Email', Icons.email, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EmailEditScreen(
                      currentEmail: email,
                      onEmailChanged: (newEmail) {
                        setState(() {
                          email = newEmail;
                        });
                      },
                    ),
                  ),
                );
              }),
              const SizedBox(height: 20),
              // Description
              buildEditableItem(
                  description, 'Description', Icons.description, () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DescriptionEditScreen(
                      currentDescription: description,
                      onDescriptionChanged: (newDescription) {
                        setState(() {
                          description = newDescription;
                        });
                      },
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableItem(String value, String label, IconData icon,
      VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color.fromARGB(183, 2, 93, 58),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onTap,
            child: const Icon(Icons.edit, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
