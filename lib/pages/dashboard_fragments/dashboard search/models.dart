class Post {
  final String image;
  final String type;
  final String title;
  final String location;
  final String quantity;
  final String owner;
  final String description1;
  final String description2;
  final String price;
  final Uri maps;
  final String periodeKontrak;

  Post({
    required this.image,
    required this.type,
    required this.title,
    required this.location,
    required this.quantity,
    required this.owner,
    required this.description1,
    required this.description2,
    required this.price,
    required this.maps,
    required this.periodeKontrak,
  });
}

// Contoh daftar postingan
List<Post> posts = [
  Post(
    image: 'assets/images/rambutan 2.jpg',
    type: 'Perkebunan',
    title: 'Rambutan Rapiah',
    location: 'Buleleng',
    quantity: '25 pohon',
    owner: 'Made Widiasa',
    description1: 'Selamat datang di kebun rambutan kami! Kami dengan bangga mempersembahkan kepada Anda Rambutan Rapiah, hasil panen terbaru dari perkebunan kami di Buleleng. Rambutan Rapiah merupakan salah satu varietas rambutan terbaik di daerah ini, dikenal karena manisnya buah dan kualitas yang konsisten.',
    description2: 'Jika Anda tertarik, silahkan lakukan survey dan ajukan penawaran. Terima kasih!' ,
    price: 'Rp 200.000 per pohon',
    maps: Uri.parse('https://maps.app.goo.gl/8ym5b5DS1zuwJCnG7'),
    periodeKontrak: 'sampai habis panen selama 1 musim',
  ),
  Post(
    image: 'assets/images/Padi.jpg',
    type: 'Pertanian',
    title: 'Padi Impari 32',
    location: 'Tabanan',
    quantity: '2 hektar',
    owner: 'Komang Sumartini',
    description1: 'Selamat datang di sawah kami! Kami dengan bangga mempersembahkan kepada Anda Padi Impari 32, hasil panen terbaru dari sawah kami di Tabanan. Padi Impari 32 merupakan salah satu varietas padi terbaik di daerah ini, dikenal karena hasil panen yang melimpah dan kualitas yang konsisten.',
    description2: 'Jika Anda tertarik, silahkan lakukan survey dan ajukan penawaran. Terima kasih!',
    price: 'Rp 30.000.000 per hektar',
    maps: Uri.parse('https://maps.app.goo.gl/bFEfvnw2AhgWxPYv7'),
    periodeKontrak: 'sampai habis panen selama 1 musim',
  ),
  Post(
    image: 'assets/images/sawo.png',
    type: 'Perkebunan',
    title: 'Sawo Manila',
    location: 'Buleleng',
    quantity: '10 pohon',
    owner: 'Ketut Mandiasa',
    description1: 'Selamat datang di kebun sawo kami! Kami dengan bangga mempersembahkan kepada Anda Sawo Manila, hasil panen terbaru dari perkebunan kami di Buleleng. Sawo Manila merupakan salah satu varietas sawo terbaik di daerah ini, dikenal karena manisnya buah dan kualitas yang konsisten.',
    description2: 'Jika Anda tertarik, silahkan lakukan survey dan ajukan penawaran. Terima kasih!',
    price: 'Rp 150.000 per pohon',
    maps: Uri.parse('https://maps.app.goo.gl/cEVb6pdRmHRj88yY8'),
    periodeKontrak: 'sampai habis panen selama 1 musim',
  ),
  // Tambahkan postingan lain di sini
];

// // import 'package:flutter/material.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// // Model Post
// class Post {
//   final int id;
//   final String image;
//   final String type;
//   final String title;
//   final String location;
//   final String quantity;
//   final String owner;
//   final String description1;
//   final String description2;
//   final String price;
//   final Uri maps;
//   final String periodeKontrak;

//   Post({
//     required this.id,
//     required this.image,
//     required this.type,
//     required this.title,
//     required this.location,
//     required this.quantity,
//     required this.owner,
//     required this.description1,
//     required this.description2,
//     required this.price,
//     required this.maps,
//     required this.periodeKontrak,
//   });

//   // Konversi dari Map ke Post
//   factory Post.fromMap(Map<String, dynamic> json) => Post(
//         id: json['id'],
//         image: json['image'],
//         type: json['type'],
//         title: json['title'],
//         location: json['location'],
//         quantity: json['quantity'],
//         owner: json['owner'],
//         description1: json['description1'],
//         description2: json['description2'],
//         price: json['price'],
//         maps: json['maps'],
//         periodeKontrak: json['periodeKontrak'],
//       );

//   // Konversi dari Post ke Map
//   Map<String, dynamic> toMap() => {
//         'id': this.id,
//         'image': image,
//         'type': type,
//         'title': title,
//         'location': location,
//         'quantity': quantity,
//         'owner': owner,
//         'description1': description1,
//         'description2': description2,
//         'price': price,
//         'maps': maps,
//         'periodeKontrak': periodeKontrak,
//       };
// }

// // Presenter untuk mengakses database
// class PostPresenter {
//   late Database _database;

//   // Inisialisasi database
//   Future<void> initDatabase() async {
//     _database = await openDatabase(
//       join(await getDatabasesPath(), 'farmfusion.db'),
//       onCreate: (db, version) {
//         return db.execute(
//           'CREATE TABLE posts(id INTEGER PRIMARY KEY, image TEXT, type TEXT, title TEXT, location TEXT, quantity TEXT, owner TEXT, description1 TEXT, description2 TEXT, price TEXT, maps TEXT, periodeKontrak TEXT)',
//         );
//       },
//       version: 1,
//     );
//   }

//   // Insert data post ke database
//   Future<void> insertPost(Post post) async {
//     await _database.insert(
//       'posts',
//       post.toMap(),
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // Mendapatkan semua data post dari database
//   Future<List<Post>> getPosts() async {
//     final List<Map<String, dynamic>> maps = await _database.query('posts');

//     return List.generate(maps.length, (i) {
//       return Post.fromMap(maps[i]);
//     });
//   }

//   // Mengupdate data post di database
//   Future<void> updatePost(Post post) async {
//     await _database.update(
//       'posts',
//       post.toMap(),
//       where: 'id = ?',
//       whereArgs: [post.id],
//     );
//   }

//   // Menghapus data post dari database
//   Future<void> deletePost(int id) async {
//     await _database.delete(
//       'posts',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }
// }
