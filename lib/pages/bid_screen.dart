import 'package:flutter/material.dart';

class BidScreen extends StatefulWidget {
  @override
  _BidScreenState createState() => _BidScreenState();
}

class _BidScreenState extends State<BidScreen> {
  TextEditingController _penawaranController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Penawaran'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan Penawaran Anda',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _penawaranController,
              decoration: InputDecoration(
                labelText: 'Penawaran',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Tambahkan logika untuk menyimpan penawaran ke database SQLite
                String penawaran = _penawaranController.text;
                // Lakukan sesuatu dengan penawaran, misalnya simpan ke SQLite
                print('Penawaran Anda: $penawaran');
                // Setelah menyimpan, Anda bisa menampilkan pesan sukses atau melakukan navigasi ke layar lain
              },
              child: Text('Kirim Penawaran'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up controller when widget is disposed
    _penawaranController.dispose();
    super.dispose();
  }
}
