import 'package:flutter/material.dart';
import '../dashboard search/detail_post.dart'; 
import '../dashboard search/models.dart';
import 'package:farmfusion_app/utils/constants.dart'; 

class DashboardSearch extends StatefulWidget {
  @override
  _DashboardSearchState createState() => _DashboardSearchState();
}

class _DashboardSearchState extends State<DashboardSearch> {
  String selectedLocation = 'Semua Lokasi';
  List<Post> filteredPosts = posts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 20),
            child: TextField(
              decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  fillColor: Constants.secondaryColor,
                  contentPadding: const EdgeInsets.all(8),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:
                        const BorderSide(color: Constants.secondaryColor),
                  )),
              onChanged: (value) {
                filterPosts(value);
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredPosts.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailPost(post: filteredPosts[index]),
                      ),
                    );
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.infinity,
                            height: 200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  10), 
                              image: DecorationImage(
                                image: AssetImage(filteredPosts[index].image),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              const Text('\u2022', style: TextStyle(fontSize: 18)),
                              Text(' ${filteredPosts[index].type}',
                            style: const TextStyle(fontSize: 13),)
                            ]
                          ),
                          Text(
                            filteredPosts[index].title,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              const Icon(Icons.location_on_outlined), 
                              Text('${filteredPosts[index].location}  '),
                              const Text('\u2022', style: TextStyle(fontSize: 14)),
                              Text(' ${filteredPosts[index].quantity}'),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(Icons.person_outline),
                              Text('${filteredPosts[index].owner}'),
                            ],
                          ) 
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void filterPosts(String value) {
    setState(() {
      filteredPosts = posts.where((post) {
        if (selectedLocation == 'Semua Lokasi' ||
            post.location == selectedLocation) {
          if (value.isEmpty) {
            return true;
          } else {
            return post.title.toLowerCase().contains(value.toLowerCase()) ||
                post.type.toLowerCase().contains(value.toLowerCase()) ||
                post.location.toLowerCase().contains(value.toLowerCase()) ||
                post.quantity.toLowerCase().contains(value.toLowerCase()) ||
                post.owner.toLowerCase().contains(value.toLowerCase());
          }
        }
        return false;
      }).toList();
    });
  }
}
