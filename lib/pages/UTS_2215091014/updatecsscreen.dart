import 'dart:io';
import 'package:farmfusion_app/widgets/app2_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:farmfusion_app/utils/constants.dart';
import 'package:farmfusion_app/endpoints/endpoints.dart';
import 'package:farmfusion_app/dto/uts.dart';

class FormUpdateCust extends StatefulWidget {
  const FormUpdateCust({Key? key, required this.objek}) : super(key: key);

  final Datas objek;

  @override
  _FormUpdateCustState createState() => _FormUpdateCustState();
}

class _FormUpdateCustState extends State<FormUpdateCust> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _nimController = TextEditingController();
  int _rating = 0;

  File? galleryFile;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.objek.tittleIssues;
    _descriptionController.text = widget.objek.description;
    _nimController.text = widget.objek.nim;
    _rating = widget.objek.rating!;
  }

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

  Future<void> _updateDataWithImage(BuildContext context) async {
    var request = MultipartRequest(
        'POST', Uri.parse('${Endpoints.endUTS}/${widget.objek.idDatas}'));
    request.fields['title_issues'] = _titleController.text;
    request.fields['description_issues'] = _descriptionController.text;
    request.fields['nim'] = _nimController.text;
    request.fields['rating'] = _rating.toString();

    if (galleryFile != null) {
      var multipartFile = await MultipartFile.fromPath(
        'image',
        galleryFile!.path,
      );
      request.files.add(multipartFile);
    }

    request.send().then((response) {
      if (response.statusCode == 200) {
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
          'Customer Service Update',
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
            TextFormField(
              controller: _nimController,
              decoration: const InputDecoration(
                labelText: 'NIM',
              ),
            ),
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
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    width: double.infinity,
                    height: 150,
                    child: galleryFile == null
                        ? Center(
                            child: Image.network(
                              width: 200,
                              Uri.parse(
                                      '${Endpoints.baseURLLive}/public/${widget.objek.imageUrl!}')
                                  .toString(),
                              errorBuilder: (context, error, stackTrace) =>
                                  const Icon(Icons.error),
                            ),
                          )
                        : Center(
                            child: Image.file(galleryFile!),
                          ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 20),
            AppButton(
              text: "Submit",
              type: ButtonType.primary,
              onPressed: () {
                _updateDataWithImage(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
