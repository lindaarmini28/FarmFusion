// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:farmfusion_app/dto/datas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:farmfusion_app/endpoints/endpoints.dart';
import 'package:farmfusion_app/services/data_services.dart';
import 'package:farmfusion_app/utils/constants.dart';
import 'package:farmfusion_app/pages/formScreen/form_screen.dart';

class DatasScreen extends StatefulWidget {
  const DatasScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _DatasScreenState createState() => _DatasScreenState();
}

class _DatasScreenState extends State<DatasScreen> {
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
        title: const Text('Data List'),
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
                    return ListTile(
                    title: data.imageUrl != null
                        ? Row(
                            children: [
                              Image.network(
                                fit: BoxFit.fitWidth,
                                width: 350,
                                Uri.parse(
                                        '${Endpoints.baseURLLive}/public/${data.imageUrl}')
                                    .toString(),
                                errorBuilder: (context, error, stackTrace) =>
                                    const Icon(Icons
                                        .error), // Display error icon if image fails to load
                              ),
                            ],
                          )
                        : null,
                    subtitle: Column(children: [
                      Text('Name : ${data.name}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Constants.secondaryColor,
                            fontWeight: FontWeight.normal,
                          )),
                      const Divider()
                    ]),
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
          Navigator.push(context, MaterialPageRoute(builder:(context) => FormScreen(),));
        },
        child: const Icon(Icons.add, color: Colors.white, size: 28),
      ),
    );
  }
}