import 'package:flutter/material.dart';
import 'package:farmfusion_app/dto/sale.dart'; // Sesuaikan dengan path dan nama model Anda
import 'package:farmfusion_app/widgets/app2_button.dart';
import 'package:farmfusion_app/helpers/dbhelper.dart'; // Sesuaikan dengan path DBHelper Anda
import 'package:flutter/widgets.dart';

class CreateSale extends StatefulWidget {
  final Post? post;

  const CreateSale({Key? key, this.post}) : super(key: key);

  @override
  _CreateSaleState createState() => _CreateSaleState();
}

class _CreateSaleState extends State<CreateSale> {
  late TextEditingController titleController;
  late TextEditingController imageController;
  late TextEditingController typeController;
  late TextEditingController locationController;
  late TextEditingController quantityController;
  late TextEditingController priceController;
  late TextEditingController periodeController;
  late TextEditingController ownerController;
  late TextEditingController mapsController;
  late TextEditingController description1Controller;
  late TextEditingController description2Controller;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller sesuai dengan post yang diberikan (jika ada)
    titleController = TextEditingController(text: widget.post?.title ?? '');
    imageController = TextEditingController(text: widget.post?.image ?? '');
    typeController = TextEditingController(text: widget.post?.type ?? '');
    locationController =
        TextEditingController(text: widget.post?.location ?? '');
    quantityController =
        TextEditingController(text: widget.post?.quantity ?? '');
    priceController = TextEditingController(text: widget.post?.price ?? '');
    periodeController =
        TextEditingController(text: widget.post?.periodeKontrak ?? '');
    ownerController = TextEditingController(text: widget.post?.owner ?? '');
    mapsController =
        TextEditingController(text: widget.post?.maps.toString() ?? '');
    description1Controller =
        TextEditingController(text: widget.post?.description1 ?? '');
    description2Controller =
        TextEditingController(text: widget.post?.description2 ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post == null ? 'Create Sale' : 'Edit Sale'), // Sesuaikan judul sesuai dengan operasi
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: imageController,
              decoration: const InputDecoration(labelText: 'Image'),
            ),
            TextFormField(
              controller: typeController,
              decoration: const InputDecoration(labelText: 'Type'),
            ),
            TextFormField(
              controller: locationController,
              decoration: const InputDecoration(labelText: 'Location'),
            ),
            TextFormField(
              controller: quantityController,
              decoration: const InputDecoration(labelText: 'Quantity'),
            ),
            TextFormField(
              controller: priceController,
              decoration: const InputDecoration(labelText: 'Price'),
            ),
            TextFormField(
              controller: periodeController,
              decoration: const InputDecoration(labelText: 'Contract Period'),
            ),
            TextFormField(
              controller: ownerController,
              decoration: const InputDecoration(labelText: 'Owner'),
            ),
            TextFormField(
              controller: mapsController,
              decoration: const InputDecoration(labelText: 'Link Maps'),
            ),
            TextFormField(
              controller: description1Controller,
              decoration: const InputDecoration(labelText: 'Description 1'),
              maxLines: null,
            ),
            TextFormField(
              controller: description2Controller,
              decoration: const InputDecoration(labelText: 'Description 2'),
              maxLines: null,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: AppButton(
                    type: ButtonType.primary,
                    onPressed: () async {
                      final post = Post(
                        id: widget.post?.id, // Tetapkan ID dari post yang ada jika sedang melakukan edit
                        title: titleController.text,
                        image: imageController.text,
                        type: typeController.text,
                        location: locationController.text,
                        quantity: quantityController.text,
                        price: priceController.text,
                        periodeKontrak: periodeController.text,
                        owner: ownerController.text,
                        maps: Uri.parse(mapsController.text),
                        description1: description1Controller.text,
                        description2: description2Controller.text,
                      );
                      if (widget.post == null) {
                        // Jika sedang membuat postingan baru
                        await DBHelper().addPost(post);
                      } else {
                        // Jika sedang melakukan edit
                        await DBHelper().updatePost(post);
                      }
                      Navigator.pop(context, post);
                    },
                    text: widget.post == null ? 'Post Product' : 'Save Changes', // Sesuaikan teks tombol sesuai dengan operasi
                  ),
                ),
                const SizedBox(width: 10), // Spasi antara tombol
                Expanded(
                  child: AppButton(
                    type: ButtonType.plain,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: 'Cancel',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10), // Spasi antara tombol dan form (opsional)
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Hapus controller saat widget di dispose
    titleController.dispose();
    imageController.dispose();
    typeController.dispose();
    mapsController.dispose();
    quantityController.dispose();
    priceController.dispose();
    periodeController.dispose();
    ownerController.dispose();
    description1Controller.dispose();
    description2Controller.dispose();
    super.dispose();
  }
}

