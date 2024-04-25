import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:farmfusion_app/dto/sale.dart'; // Sesuaikan dengan path dan nama model Anda
import 'package:farmfusion_app/helpers/dbhelper.dart'; // Sesuaikan dengan path DBHelper Anda
import 'package:flutter/widgets.dart';
import '../dashboard seles/componen/create_sale.dart';
import 'package:farmfusion_app/utils/constants.dart';

class SaleDashboard extends StatefulWidget {
  const SaleDashboard({Key? key}) : super(key: key);

  @override
  _SaleDashboardState createState() => _SaleDashboardState();
}

class _SaleDashboardState extends State<SaleDashboard> {
  late List<Post> _posts;
  late DBHelper _dbHelper;

  @override
  void initState() {
    super.initState();
    _dbHelper = DBHelper();
    _posts = []; // Inisialisasi _posts sebagai list kosong
    _loadPosts();
  }

  Future<void> _loadPosts() async {
    try {
      _posts = await _dbHelper.getPosts();
      setState(() {}); // Refresh UI
    } catch (error) {
      print('Error loading posts: $error');
    }
  }

  Future<void> _editPost(Post post) async {
    // Navigasi ke halaman CreateSale dengan mode edit
    final editedPost = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CreateSale(
          post: post, // Kirim post yang ingin diedit
        ),
      ),
    );
    if (editedPost != null) {
      await DBHelper().updatePost(editedPost);
      _loadPosts(); // Reload posts setelah edit
    }
  }

  Future<void> _deletePost(int postId) async {
    await _dbHelper.deletePost(postId); // Hapus post dari database
    _loadPosts(); // Reload posts setelah delete
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _posts.isEmpty
          ? const Center(
              child: Text('No posts available'),
            )
          : ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                final post = _posts[index];
                return Card(
                child: ListTile(
                  title: Text(post.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children:[
                          const Icon (Icons.location_on, size: 16, color: Colors.grey,),
                          const SizedBox(width: 3,),
                          Text(post.location),
                        ],
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        children:[
                          const Icon (Icons.monetization_on, size: 16, color: Colors.grey,),
                          const SizedBox(width: 3,),
                          Text(post.price),
                        ],
                      ),
                      const SizedBox(height: 3,),
                      Row(
                        children:[
                          const Icon (Icons.calendar_today, size: 16, color: Colors.grey,),
                          const SizedBox(width: 3,),
                          Text(post.periodeKontrak),
                        ],
                      ),
                      Row(
                        children:[
                      IconButton(
                        icon: const Icon(Icons.edit, color: Constants.secondaryColor),
                        onPressed: () {
                          _editPost(post);
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Constants.secondaryColor),
                        onPressed: () {
                          _deletePost(post.id!);
                        },
                      ),
                        ],
                      ),
                    ],
                )
                )
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateSale(),
            ),
          ).then((_) {
            _loadPosts();
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
