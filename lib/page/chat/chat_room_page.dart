import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/services/chat_service.dart';
import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  final String userEmail;
  final String userUID;

  const ChatRoomPage({super.key, required this.userEmail, required this.userUID});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.userEmail),
        ),
        body: Column(
          children: [
            Expanded(
              child: _buildMessagingList(),
            ),
            _buildMessagingInput(),
          ],
        ));
  }

  Widget _buildMessagingList() {
    return StreamBuilder(
      stream: _chatService.getMessage(
          userId: _firebaseAuth.currentUser!.uid, otherUserId: widget.userUID),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error.toString()}'),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                bool isCurrentUser = snapshot.data!.docs[index]['senderId'] == _firebaseAuth.currentUser!.uid;
                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                    children: [
                      Text(snapshot.data!.docs[index]['senderEmail']),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(color: isCurrentUser ? Colors.indigo : Colors.teal),
                        child: Text(
                          snapshot.data!.docs[index]['message'],
                        ),
                      )
                    ],
                  ),
                );
              });
        }
      },
    );
  }

  Widget _buildMessagingInput() {
    return Container(
      color: Colors.white30,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
            ),
          ),
          IconButton(
            onPressed: () => sendMessage(),
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }

  void sendMessage() async {
    if (messageController.text.isEmpty) {
      return;
    } else {
      _chatService.sendMessage(
        message: messageController.text,
        receiverId: widget.userUID,
      );
      messageController.clear();
    }
  }
}
