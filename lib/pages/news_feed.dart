// ignore_for_file: unused_import

import 'package:flutter/material.dart';
import 'package:farmfusion_app/dto/news.dart';
import 'package:farmfusion_app/services/data_services.dart';
import 'package:farmfusion_app/endpoints/endpoints.dart';
import 'package:farmfusion_app/pages/formScreen/form_screen.dart';
import 'package:farmfusion_app/utils/constants.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  _NewsFeedState createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  late Future<List<News>> _news;

  final _simpanTitle = TextEditingController();
  final _simpanBody = TextEditingController();

  @override
  void initState() {
    super.initState();
    _news = DataServices.fetchNews();
  }

  @override
  void dispose() {
    _simpanTitle.dispose();
    _simpanBody.dispose();
    super.dispose();
  }

  void showIsian(News post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(post.title),
        content: SizedBox(
          height: 200,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Image.network(post.photo),
                Text(post.idCategory.toString()),
                Text(post.id),
                Text(post.body),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showInput() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Masukkan Data"),
        content: Column(
          children: [
            TextField(
              controller: _simpanTitle,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueGrey.shade500)),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
                hintText: 'Title'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _simpanBody,
              decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color:Constants.secondaryColor)),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
                hintText: 'Body'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              DataServices.sendNews(_simpanTitle.text, _simpanBody.text);
              Navigator.pop(context);
              setState(() {
                _news = DataServices.fetchNews();
              });
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  void _deleteNews(String id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Konfirmasi"),
        content: const Text("Apakah Anda yakin ingin menghapus berita ini?"),
        actions: [
          TextButton(
            onPressed: () {
              DataServices.deleteData(id);
              Navigator.pop(context);
              setState(() {
                _news = DataServices.fetchNews();
              });
            },
            child: const Text('Ya'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Tidak'),
          ),
        ],
      ),
    );
  }

  void _showUpdateDialog(News post) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update Berita"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: TextEditingController(text: post.title),
              onChanged: (value) {
                post.title = value;
              },
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: TextEditingController(text: post.body),
              onChanged: (value) {
                post.body = value;
              },
              decoration: const InputDecoration(
                labelText: "Body",
                border: OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              DataServices.updateData(post.id, post.title, post.body);
              Navigator.pop(context);
              setState(() {
                _news = DataServices.fetchNews();
              });
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: Center(
        child: FutureBuilder<List<News>>(
          future: _news,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return GestureDetector(
                    onTap: () {
                      showIsian(post);
                    },
                    child: Container(
                      height: 136,
                      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFE0E0E0)),
                        borderRadius: BorderRadius.circular(8.0)
                      ),
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(post.photo),
                              )
                            )
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post.title,
                                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  post.body,
                                  style: const TextStyle(fontSize: 16),
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.delete),
                                      onPressed: () {
                                        _deleteNews(post.id);
                                      }
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        _showUpdateDialog(post);
                                      }
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showInput();
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}