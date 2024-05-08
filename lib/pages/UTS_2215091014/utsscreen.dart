import 'package:farmfusion_app/pages/UTS_2215091014/detail_screen.dart';
import 'package:farmfusion_app/pages/UTS_2215091014/form_createcs.dart';
import 'package:flutter/material.dart';
import 'package:farmfusion_app/dto/uts.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farmfusion_app/endpoints/endpoints.dart';
import 'package:farmfusion_app/utils/constants.dart';
import 'package:farmfusion_app/pages/UTS_2215091014/data_services.dart';

class UtsCSScreen extends StatefulWidget {
  const UtsCSScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _UtsCSScreenState createState() => _UtsCSScreenState();
}

class _UtsCSScreenState extends State<UtsCSScreen> {
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
          'UTS Data List',
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
                itemCount: post.length,
                itemBuilder: (context, index) {
                  final data = post[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailCSScreen(data: data),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(15), // Adjust the radius here
                      ),
                      child: ClipRRect(
                        borderRadius:
                            BorderRadius.circular(15), // Adjust the radius here
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
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${data.tittleIssues}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 18,
                                          color: Constants.secondaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
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
                                ],
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
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Constants.secondaryColor,
        tooltip: 'Increment',
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FormCust(),
              ));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}
