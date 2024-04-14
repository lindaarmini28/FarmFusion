import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:farmfusion_app/dto/sale.dart';
import 'package:flutter/foundation.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _db;

  factory DBHelper() => _instance;

  DBHelper._internal();

  Future<Database> get db async {
    _db ??= await initDatabase();
    return _db!;
  }

  Future<Database> initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'farmfusion.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE posts(
        id INTEGER PRIMARY KEY,
        image BLOB, // Menggunakan tipe data BLOB untuk menyimpan gambar
        type TEXT,
        title TEXT,
        location TEXT,
        maps TEXT,
        quantity TEXT,
        owner TEXT,
        description1 TEXT,
        description2 TEXT,
        price TEXT,
        periodeKontrak TEXT
      )
    ''');
  }

  Future<Post> addPost(Post post) async {
    var dbClient = await db;
    
    // Mengonversi gambar ke array byte
    List<int> imageBytes = await post.image!.readAsBytes();
    
    // Menyimpan gambar sebagai BLOB ke database
    post.id = await dbClient.insert('posts', {
      'image': Uint8List.fromList(imageBytes),
      'type': post.type,
      'title': post.title,
      'location': post.location,
      'quantity': post.quantity,
      'owner': post.owner,
      'description1': post.description1,
      'description2': post.description2,
      'price': post.price,
      'maps': post.maps.toString(),
      'periodeKontrak': post.periodeKontrak,
    });
    return post;
  }

  Future<List<Post>> getPosts() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps =
        await dbClient.query('posts', orderBy: 'id DESC');
    List<Post> posts = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        // Mengonversi BLOB kembali ke array byte
        Uint8List imageBytes = maps[i]['image'];
        // Membuat objek File dari array byte
        File imageFile = await _writeImageToFile(imageBytes);
        
        // Mengonversi nilai map ke objek Post, termasuk file gambar
        maps[i]['image'] = imageFile;
        posts.add(Post.fromMap(maps[i]));
      }
    }
    return posts;
  }

  // Fungsi untuk menyimpan gambar sebagai file sementara dan membuat objek File darinya
Future<File> _writeImageToFile(Uint8List imageBytes) async {
  // Mendapatkan direktori temporary
  Directory tempDir = await getTemporaryDirectory();
  String tempPath = tempDir.path;

  // Menampilkan direktori temporary
  print('Temporary directory path: $tempPath');

  // Membuat objek file dengan nama temp_image.png di direktori temporary
  File imageFile = File('$tempPath/temp_image.png');

  // Menuliskan array byte gambar ke file sementara
  try {
    await imageFile.writeAsBytes(imageBytes);
    print('Image file successfully written to temporary directory.');
  } catch (error) {
    print('Error writing image file to temporary directory: $error');
  }

  // Mengembalikan objek File yang merepresentasikan file gambar yang baru ditulis
  return imageFile;
}


  Future<int> deletePost(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'posts',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> updatePost(Post post) async {
    var dbClient = await db;
    return await dbClient.update(
      'posts',
      post.toMap(),
      where: 'id = ?',
      whereArgs: [post.id],
    );
  }

  Future<void> close() async {
    try {
      var dbClient = await db;
      if (dbClient.isOpen) {
        await dbClient.close();
        _db = null;
      }
    } catch (error) {
      debugPrint('Error closing database: $error');
    }
  }
}






// import 'package:flutter/foundation.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
// import 'dart:io' as io;
// import 'package:path_provider/path_provider.dart';
// import 'package:farmfusion_app/dto/sale.dart';

// class DBHelper {
//   static final DBHelper _instance = DBHelper._internal();
//   static Database? _db;

//   factory DBHelper() => _instance;

//   DBHelper._internal();

//   Future<Database> get db async {
//     _db ??= await initDatabase();
//     return _db!; // Gunakan _db yang sudah diinisialisasi
//   }

//   Future<Database> initDatabase() async {
//     io.Directory documentsDirectory =
//         await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, 'farmfusion.db');
//     var db = await openDatabase(path, version: 1, onCreate: _onCreate);
//     return db;
//   }

//   void _onCreate(Database db, int version) async {
//     // Definisikan skema tabel Anda di sini
//     await db.execute('''
//       CREATE TABLE posts(
//         id INTEGER PRIMARY KEY,
//         image TEXT,
//         type TEXT,
//         title TEXT,
//         location TEXT,
//         quantity TEXT,
//         owner TEXT,
//         description1 TEXT,
//         description2 TEXT,
//         price TEXT,
//         maps TEXT,
//         periodeKontrak TEXT
//       )
//     ''');
//   }

//   Future<Post> addPost(Post post) async {
//     var dbClient = await db;
//     post.id = await dbClient.insert('posts', post.toMap());
//     return post;
//   }

//   Future<List<Post>> getPosts() async {
//     var dbClient = await db;
//     List<Map<String, dynamic>> maps =
//         await dbClient.query('posts', orderBy: 'id DESC');
//     List<Post> posts = [];
//     if (maps.isNotEmpty) {
//       for (int i = 0; i < maps.length; i++) {
//         posts.add(Post.fromMap(maps[i]));
//       }
//     }
//     return posts;
//   }

//   Future<int> deletePost(int id) async {
//     var dbClient = await db;
//     return await dbClient.delete(
//       'posts',
//       where: 'id = ?',
//       whereArgs: [id],
//     );
//   }

//   Future<int> updatePost(Post post) async {
//     var dbClient = await db;
//     return await dbClient.update(
//       'posts',
//       post.toMap(),
//       where: 'id = ?',
//       whereArgs: [post.id],
//     );
//   }

//   Future<void> close() async {
//     try {
//       var dbClient = await db;
//       if (dbClient.isOpen) {
//         await dbClient.close();
//         _db = null;
//       }
//     } catch (error) {
//       debugPrint('Error closing database: $error');
//     }
//   }
// }