// Digunakan untuk membuat class Post yang berisi atribut yang akan digunakan untuk menyimpan data dari database
class Post {
  int? id;
  String? image;
  String type;
  String title;
  String location;
  String quantity;
  String owner;
  String description1;
  String description2;
  String price;
  Uri maps;
  String periodeKontrak;

  Post({
    this.id,
    this.image,
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

  // Factory method untuk membuat objek Post dari Map
  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      id: map['id'],
      image: map['image'],
      type: map['type'],
      title: map['title'],
      location: map['location'],
      quantity: map['quantity'],
      owner: map['owner'],
      description1: map['description1'],
      description2: map['description2'],
      price: map['price'],
      maps: Uri.parse(map['maps']),
      periodeKontrak: map['periodeKontrak'],
    );
  }

  // Method untuk mengonversi objek Post menjadi Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'image': image,
      'type': type,
      'title': title,
      'location': location,
      'quantity': quantity,
      'owner': owner,
      'description1': description1,
      'description2': description2,
      'price': price,
      'maps': maps.toString(),
      'periodeKontrak': periodeKontrak,
    };
  }
}