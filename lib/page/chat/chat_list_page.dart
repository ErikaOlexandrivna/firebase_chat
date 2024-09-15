import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/const.dart';
import 'package:firebase_chat/page/chat/chat_room_page.dart';
import 'package:flutter/material.dart';
import'package:firebase_chat/models/user_model.dart';

class ChatListPage extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  ChatListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat list'),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          InkWell(onTap: () => signOut(), child: const Icon(Icons.door_back_door_outlined))
        ],
      ),
      body: _buildChatList(),
    );
  }

  Widget _buildChatList() {
    return StreamBuilder(
      stream: _firestore.collection(user).snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final userDoc = snapshot.data!.docs[index];
                final userModel = UserModel.fromMap(userDoc.data() as Map<String, dynamic>);
                if (userModel.uid == _firebaseAuth.currentUser!.uid) {
                  return const SizedBox.shrink();
                }
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  elevation: 2,
                  child: ListTile(
                    contentPadding:  const EdgeInsets.all(12),
                    leading:  const CircleAvatar(
                      backgroundColor: Colors.blueAccent,
                    ),

                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatRoomPage(
                            user: userModel,
                          ),
                        ),
                      );
                    },
                    title:  const Text(
                      style: TextStyle(color:Colors.white,fontWeight:FontWeight.bold ),
                      user,
                    ),
                    subtitle: Text(userModel.uid),
                  ),
                );
              });
        }
      },
    );
  }

  void signOut() {
    _firebaseAuth.signOut();
  }
}
