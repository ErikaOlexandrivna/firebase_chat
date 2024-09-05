import 'package:flutter/material.dart';

class ChatRoomPage extends StatefulWidget {
  final String userEmail;
  final String userUID;

  const ChatRoomPage({super.key, required this.userEmail, required this.userUID});

  @override
  State<ChatRoomPage> createState() => _ChatRoomPageState();
}

class _ChatRoomPageState extends State<ChatRoomPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.userEmail),
      ),
      body: Column(
        children: [
          _buildMessagingList(),
          _buildMessagingInput(),
        ],
      )
    );
  }

  _buildMessagingList() {

 }

  _buildMessagingInput() {}
}
