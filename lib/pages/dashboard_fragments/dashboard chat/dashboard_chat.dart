import 'package:flutter/material.dart';
import '../../../models/chatUsersModel.dart';
import '../../../widgets/conversation_list.dart'; // Import chatUsersModel.dart jika diperlukan

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
        name : "Made Widiasa",
        messageText: "Pagi bapak, deal ya?",
        imageURL: "assets/images/user1.jpg",
        time: "Now"),
    ChatUsers(
        name: "Komang Sumartini",
        messageText: "Terimakasih pak.",
        imageURL: "assets/images/user2.jpg",
        time: "Yesterday"),
    ChatUsers(
        name: "Nyoman Witana Yasa",
        messageText: "Senang berbisnis dengan anda.",
        imageURL: "assets/images/user3.jpg",
        time: "31 Mar"),
    ChatUsers(
        name: "Ketut Mertana",
        messageText: "Kapan bisa dilakukan survey, bapak?",
        imageURL: "assets/images/user4.jpg",
        time: "28 Mar"),
    ChatUsers(
        name: "Nyoman Edi Juliana",
        messageText: "Terimakasih atas kerjasamanya.",
        imageURL: "assets/images/user5.jpg",
        time: "23 Mar"),
    ChatUsers(
        name: "Putu Budiasa",
        messageText: "Terimakasih pak.",
        imageURL: "assets/images/user6.jpeg",
        time: "17 Mar"),
  ];

  List<ChatUsers> filteredChatUsers = [];

  @override
  void initState() {
    filteredChatUsers = List.from(chatUsers);
    super.initState();
  }

  void filterUsers(String query) {
    setState(() {
      filteredChatUsers = chatUsers.where((user) {
        // Implementasi logika pencarian berdasarkan nama
        return user.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  onChanged: (value) => filterUsers(value),
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.grey.shade600,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade100,
                    contentPadding: const EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Colors.grey.shade100),
                    ),
                  ),
                ),
              ),
            ),
            ListView.builder(
              itemCount: filteredChatUsers.length,
              shrinkWrap: true,
              padding: const EdgeInsets.only(top: 16),
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return ConversationList(
                  name: filteredChatUsers[index].name,
                  messageText: filteredChatUsers[index].messageText,
                  imageUrl: filteredChatUsers[index].imageURL,
                  time: filteredChatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
