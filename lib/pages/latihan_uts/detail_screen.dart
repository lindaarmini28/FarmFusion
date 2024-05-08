import 'package:farmfusion_app/pages/latihan_uts/update_screen.dart';
import 'package:flutter/material.dart';
import 'package:farmfusion_app/dto/datas.dart';
import 'package:farmfusion_app/pages/latihan_uts/endpoints.dart';
import 'package:farmfusion_app/utils/constants.dart';
import 'package:farmfusion_app/widgets/app2_button.dart';
import 'package:farmfusion_app/pages/latihan_uts/data_services.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailScreen extends StatelessWidget {
  final Datas data;

  const DetailScreen({Key? key, required this.data}) : super(key: key);

  Future<void> _deleteData(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Konfirmasi'),
          content: Text('Apakah Anda yakin ingin menghapus data ini?'),
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
                  await DataServices.deleteDatas(data.idDatas.toString());
                  Navigator.of(context).pop(); // Tutup dialog
                  Navigator.pushReplacementNamed(context, '/lat-uts-screen');
                } catch (e) {
                  print('Gagal menghapus data: $e');
                }
              },
              child: Text('Hapus'),
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
          'Detail Post',
          style: GoogleFonts.roboto(
            fontSize: 22,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        backgroundColor: Constants.secondaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
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
            const SizedBox(height: 20),
            // Nama di bawah gambar
            Text(
              'Name: ${data.name}',
              style: GoogleFonts.poppins(
                fontSize: 18,
                color: Constants.secondaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Tombol Edit dan Delete dalam satu baris
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Tombol Edit
                AppButton(
                  type: ButtonType.primary,
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FormUpdateScreen(objek: data),));// Tambahkan logika untuk tombol edit di sini
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
