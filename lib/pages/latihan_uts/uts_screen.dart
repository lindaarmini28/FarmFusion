import 'package:flutter/material.dart';
import 'package:farmfusion_app/dto/datas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farmfusion_app/pages/latihan_uts/endpoints.dart';
import 'package:farmfusion_app/utils/constants.dart';
import 'package:farmfusion_app/pages/latihan_uts/form_create.dart';
import 'package:farmfusion_app/pages/latihan_uts/detail_screen.dart';
import 'package:farmfusion_app/pages/latihan_uts/data_services.dart';

class LatUtsScreen extends StatefulWidget {
  const LatUtsScreen({Key? key}) : super(key: key);

  @override
  _LatUtsScreenState createState() => _LatUtsScreenState();
}

class _LatUtsScreenState extends State<LatUtsScreen> {
  Future<List<Datas>>? _datas;

  @override
  void initState() {
    super.initState();
    _datas = DataServices.fetchDatas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Latihan UTS Data List',
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
                context, '/dashboard'); // Default back button behavior
            // You can add additional actions here (e.g., show confirmation dialog)
          },
        ),
      ),
      body: Center(
        child: FutureBuilder<List<Datas>>(
          future: _datas,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final post = snapshot.data!;
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final data = post[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailScreen(data: data),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15), // Adjust the radius here
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15), // Adjust the radius here
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (data.imageUrl != null)
                              Image.network(
                                '${Endpoints.baseURLLive}/public/${data.imageUrl}',
                                width: double.infinity,
                                height: 200,
                                fit: BoxFit.cover,
                              ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                '${data.name}',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: Constants.secondaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            // Show a loading indicator while waiting for data
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.secondaryColor,
        tooltip: 'Increment',
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FormScreen()),
          );
        },
        child: Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }

}
