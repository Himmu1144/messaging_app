import 'package:flutter/material.dart';
import 'package:mimiko/pages/chat_page.dart';
import 'package:mimiko/services/auth/auth_service.dart';
import 'package:mimiko/components/my_drawer.dart';
import 'package:mimiko/services/chat/chat_service.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  void logout() async {
    // get the auth service
    final authService = AuthService();

    // sign out
    authService.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
            child: Text(
          'Home Page',
          style: TextStyle(fontSize: 20),
        )),
      ),
      drawer: const MyDrawer(),
      body: StreamBuilder(
          stream: _chatService.getUserStream(),
          builder: (context, snapshot) {
            // if it has errors
            if (snapshot.hasError) {
              return const Text('Error');
            }

            // if its in loading state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Loading...');
            }

            // return list tile
            return ListView(
              children: snapshot.data!
                  .map<Widget>((userData) => _buildListItem(userData, context))
                  .toList(),
            );
          }),
    );
  }

  // building list tile for user
  Widget _buildListItem(Map<String, dynamic> userData, BuildContext context) {
    // display all user except current user
    if (userData['email'] != _authService.getCurrentUser()!.email) {
      return GestureDetector(
        onTap: () {
          // Navigator.pushNamed(
          //   context,
          //   '/chat_box',
          //   arguments: {'message': userData['email'], receiverEmail:userData['email', receiverID:userData['id']]},
          // );
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverEmail: userData['email'],
                        receiverID: userData['uid'],
                      )));
        },
        child: Container(
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12)),
          child: Row(
            children: [const Icon(Icons.person), Text(userData['email'])],
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
