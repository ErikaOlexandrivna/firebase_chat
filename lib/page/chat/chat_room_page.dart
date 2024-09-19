import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/services/chat_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_chat/models/user_model.dart';
import 'package:intl/intl.dart';

class ChatRoomPage extends StatefulWidget {
  final UserModel user;

  const ChatRoomPage({super.key, required this.user});

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
          title: Text(widget.user.email),
          centerTitle: true,
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
          userId: _firebaseAuth.currentUser!.uid, otherUserId: widget.user.uid),
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
              bool isCurrentUser = snapshot.data!.docs[index]['senderId'] ==
                  _firebaseAuth.currentUser!.uid;
              String message = snapshot.data!.docs[index]['message'];
              String senderEmail = snapshot.data!.docs[index]['senderEmail'];
              DateTime timestamp = (snapshot.data!
                  .docs[index]['timestamp'] as Timestamp).toDate();

              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 16),
                child: Column(
                  crossAxisAlignment: isCurrentUser
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
                  children: [
                    Text(
                      senderEmail,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isCurrentUser ? Colors.indigo : Colors.teal,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: isCurrentUser ? Colors.indigo[100] : Colors
                            .teal[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: isCurrentUser ? CrossAxisAlignment
                            .end : CrossAxisAlignment.start,
                        children: [
                          Text(
                            message,
                            style: TextStyle(color: Colors.black),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            DateFormat('HH:mm, dd MMM').format(timestamp),
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }

  Widget _buildMessagingInput() {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageController,
              decoration: InputDecoration(
                hintText: 'Type a message',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 10),
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () => sendMessage(),
            icon: const Icon(Icons.send, color: Colors.blueAccent),
          ),
        ],
      ),
    );
  }

  void sendMessage() async {
    if (messageController.text.isEmpty) {
      return;
    } else {
      await _chatService.sendMessage(
        message: messageController.text,
        receiverId: widget.user.uid,
      );
      messageController.clear();
    }
  }
}