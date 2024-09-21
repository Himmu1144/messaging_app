import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mimiko/services/auth/auth_service.dart';
import 'package:mimiko/services/chat/chat_service.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverID;

  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  final TextEditingController myController = TextEditingController();

  // getting chat and auth services
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void sendMessage() async {
    if (myController.text.isNotEmpty) {
      await _chatService.sendMessage(receiverID, myController.text);
      myController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    // final args =
    //     ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    String senderID = _authService.getCurrentUser()!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(receiverEmail),
      ),
      body: Column(
        children: [
          Expanded(
              child: StreamBuilder(
                  stream: _chatService.getMessages(receiverID, senderID),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Error');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text('Loading...');
                    }

                    return ListView(
                      children: snapshot.data!.docs
                          .map((doc) => _buidMessageItem(doc))
                          .toList(),
                    );
                  })),
          Row(
            children: [
              Expanded(
                  child: TextField(
                controller: myController,
              )),
              IconButton(
                  onPressed: sendMessage, icon: const Icon(Icons.arrow_upward))
            ],
          )
        ],
      ),
    );
  }
}

Widget _buidMessageItem(DocumentSnapshot doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  return Text(data['message']);
}
