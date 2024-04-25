import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path_provider/path_provider.dart';
import 'package:farmfusion_app/dto/sale.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  static Database? _db;

  factory DBHelper() => _instance;

  DBHelper._internal();

  Future<Database> get db async {
    _db ??= await initDatabase();
    return _db!; // Gunakan _db yang sudah diinisialisasi
  }

  Future<Database> initDatabase() async {
    io.Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'farmfusionekx.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int version) async {
    // Definisikan skema tabel Anda di sini
    await db.execute('''
      CREATE TABLE posts(
        id INTEGER PRIMARY KEY,
        image TEXT,
        type TEXT,
        title TEXT,
        location TEXT,
        quantity TEXT,
        owner TEXT,
        description1 TEXT,
        description2 TEXT,
        price TEXT,
        maps TEXT,
        periodeKontrak TEXT
      )
    ''');
  }

  Future<Post> addPost(Post post) async {
    var dbClient = await db;
    post.id = await dbClient.insert('posts', post.toMap());
    return post;
  }

  Future<List<Post>> getPosts() async {
    var dbClient = await db;
    List<Map<String, dynamic>> maps =
        await dbClient.query('posts', orderBy: 'id DESC');
    List<Post> posts = [];
    if (maps.isNotEmpty) {
      for (int i = 0; i < maps.length; i++) {
        posts.add(Post.fromMap(maps[i]));
      }
    }
    return posts;
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