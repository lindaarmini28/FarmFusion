import 'package:farmfusion_app/pages/UTS_2215091014/updatecsscreen.dart';
import 'package:flutter/material.dart';
import 'package:farmfusion_app/dto/uts.dart';
import 'package:farmfusion_app/endpoints/endpoints.dart';
import 'package:farmfusion_app/utils/constants.dart';
import 'package:farmfusion_app/widgets/app2_button.dart';
import 'package:farmfusion_app/pages/UTS_2215091014/data_services.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailCSScreen extends StatelessWidget {
  final Datas data;

  const DetailCSScreen({Key? key, required this.data}) : super(key: key);

  Future<void> _deleteData(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi'),
          content: const Text('Apakah Anda yakin ingin menghapus data ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
              },
              child: Text('Batal'),
            ),
            TextButton(
              onPressed: () async {
                try {
                  await DataServices.deleteDatas(data.idDatas);
                  Navigator.of(context).pop(); // Tutup dialog
                  Navigator.pushReplacementNamed(context, '/uts-cs-screen');
                } catch (e) {
                  print('Gagal menghapus data: $e');
                }
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detail Customer Service',
          style: GoogleFonts.roboto(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Constants.secondaryColor,
        leading: IconButton(
          icon: const Icon(Icons
              .arrow_back, color: Colors.white,), // Customize icon (optional)// Customize color (optional)
          onPressed: () {
            // Your custom back button functionality here
            Navigator.pushReplacementNamed(
                context, '/uts-cs-screen'); // Default back button behavior
            // You can add additional actions here (e.g., show confirmation dialog)
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  '${Endpoints.baseURLLive}/public/${data.imageUrl}',
                  width: double.infinity,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title:',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${data.tittleIssues}',
                    style: GoogleFonts.roboto(
                      fontSize: 20,
                      color: Colors.black,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Description:',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${data.description}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'NIM:',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${data.nim}',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Rating:',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  if (data.rating != null)
                    Row(
                      children: List.generate(
                        data.rating!,
                        (index) => const Icon(
                          Icons.star,
                          color: Constants.secondaryColor,
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol Edit
                AppButton(
                  type: ButtonType.primary,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FormUpdateCust(objek: data),
                        )); // Tambahkan logika untuk tombol edit di sini
                  },
                  text: 'Edit',
                  icon: Icons.edit, // Menambahkan ikon Edit
                ),
                const SizedBox(width: 10), // Spasi antara tombol
                // Tombol Delete
                AppButton(
                  type: ButtonType.plain,
                  onPressed: () {
                    _deleteData(context); // Panggil method untuk menghapus data
                  },
                  text: 'Delete',
                  icon: Icons.delete, // Menambahkan ikon Delete
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
