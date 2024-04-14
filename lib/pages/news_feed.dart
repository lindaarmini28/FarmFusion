import 'package:flutter/material.dart';
import 'package:farmfusion_app/dto/news.dart';
import 'package:farmfusion_app/services/data_services.dart';

class NewsFeed extends StatefulWidget {
  const NewsFeed({Key? key}) : super(key: key);

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}

class _NewsFeedState extends State<NewsFeed> {
  late Future<List<News>> _news;

  @override
  void initState() {
    super.initState();
    _news = DataServices.fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              _showAddNewsDialog(context);
            },
          ),
        ],
      ),
      body: Center(
        child: FutureBuilder<List<News>>(
          future: _news,
          builder: ((context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return ListTile(
                    leading: Image.network(
                      post.photo,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                    title: Text(post.title),
                    subtitle: Text(post.body),
                    onTap: () {
                      _showEditNewsDialog(context, post);
                    },
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        _showDeleteConfirmationDialog(context, post.idCategory);
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          }),
        ),
      ),
    );
  }

  Future<void> _showAddNewsDialog(BuildContext context) async {
    String title = '';
    String body = '';

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Tambah Berita'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Judul'),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Isi Berita'),
                onChanged: (value) => body = value,
                maxLines: 5,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                _createNews(title, body);
                Navigator.pop(context);
              },
              child: const Text('Tambahkan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showEditNewsDialog(BuildContext context, News news) async {
    String title = news.title;
    String body = news.body;

    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Berita'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Judul'),
                controller: TextEditingController(text: title),
                onChanged: (value) => title = value,
              ),
              TextField(
                decoration: const InputDecoration(labelText: 'Isi Berita'),
                controller: TextEditingController(text: body),
                onChanged: (value) => body = value,
                maxLines: 5,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                _updateNews(news.idCategory, title, body);
                Navigator.pop(context);
              },
              child: const Text('Simpan'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, int id) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Hapus Berita'),
          content: const Text('Apakah Anda yakin ingin menghapus berita ini?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Batal'),
            ),
            ElevatedButton(
              onPressed: () {
                _deleteNews(id); // Panggil metode _deleteNews di sini
                Navigator.pop(context);
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _createNews(String title, String body) async {
    try {
      await DataServices.createNews(title, body);
      setState(() {
        _news = DataServices.fetchNews();
      });
    } catch (error) {
      print('Error creating news: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal menambahkan berita'),
        ),
      );
    }
  }

Future<void> _updateNews(int id, String title, String body) async {
  try {
    await DataServices.updateNews(id, title, body);
    // Perbarui daftar berita setelah pembaruan berhasil
    setState(() {
      // Refresh data dengan memanggil fetchNews kembali
      _news = DataServices.fetchNews();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Berita berhasil diperbarui'),
      ),
    );
  } catch (error) {
    print('Error updating news: $error');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gagal memperbarui berita'),
      ),
    );
  }
}


  Future<void> _deleteNews(int id) async {
    try {
      await DataServices.deleteNews(id);
      setState(() {
        _news = DataServices.fetchNews();
      });
    } catch (error) {
      print('Error deleting news: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Gagal menghapus berita'),
        ),
      );
    }
  }
}
