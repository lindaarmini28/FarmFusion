import 'dart:io';
import 'package:farmfusion_app/widgets/app2_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:farmfusion_app/utils/constants.dart';
import 'package:farmfusion_app/endpoints/endpoints.dart';

class FormCust extends StatefulWidget {
  const FormCust({Key? key}) : super(key: key);

  @override
  _FormCust createState() => _FormCust();
}

class _FormCust extends State<FormCust> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nimController = TextEditingController();
  int _rating = 0;

  File? galleryFile;
  final picker = ImagePicker();

  _showPicker({required BuildContext context}) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Photo Library'),
                onTap: () {
                  getImage(ImageSource.gallery);
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('Camera'),
                onTap: () {
                  getImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future getImage(ImageSource img) async {
    final pickedFile = await picker.pickImage(source: img);
    setState(() {
      if (pickedFile != null) {
        galleryFile = File(pickedFile.path);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Nothing is selected')),
        );
      }
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _nimController.dispose();
    super.dispose();
  }

  saveData() {
    debugPrint(_titleController.text);
    debugPrint(_descriptionController.text);
    debugPrint(_nimController.text);
    debugPrint(_rating.toString());
  }

  Future<void> _postDataWithImage(BuildContext context) async {
    if (galleryFile == null) {
      return; // Handle case where no image is selected
    }

    var request = MultipartRequest('POST', Uri.parse(Endpoints.uts));
    request.fields['nim'] = _nimController.text;
    request.fields['title_issues'] =
        _titleController.text; // Add other data fields
    request.fields['description_issues'] = _descriptionController.text;
    request.fields['rating'] = _rating.toString();

    var multipartFile = await MultipartFile.fromPath(
      'image',
      galleryFile!.path,
    );
    request.files.add(multipartFile);

    request.send().then((response) {
      // Handle response (success or error)
      if (response.statusCode == 201) {
        debugPrint('Data and image posted successfully!');
        Navigator.pushReplacementNamed(context, '/uts-cs-screen');
      } else {
        debugPrint('Error posting data: ${response.statusCode}');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'Customer Service',
          style: GoogleFonts.roboto(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Constants.secondaryColor,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nimController,
              decoration: const InputDecoration(
                labelText: 'NIM',
              ),
            ),
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title Issues',
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi Issues',
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Text(
                  'Rating: ',
                  style: TextStyle(fontSize: 16),
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _rating = index + 1;
                        });
                      },
                      child: Icon(
                        Icons.star,
                        size: 30,
                        color: _rating >= index + 1
                            ? Constants.secondaryColor
                            : Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              children: [
                GestureDetector(
                  onTap: () {
                    _showPicker(context: context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Constants.secondaryColor.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 150,
                    child: galleryFile == null
                        ? const Center(
                            child: Icon(Icons.add_a_photo, size: 45, color: Constants.secondaryColor,)
                          )
                        : Center(
                            child: Image.file(galleryFile!),
                          ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            AppButton(
              text: "Submit",
              type: ButtonType.primary,
              onPressed: () {
                _postDataWithImage(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
