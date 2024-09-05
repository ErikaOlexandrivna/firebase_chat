import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_chat/const.dart';
import 'package:flutter/material.dart';


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
          InkWell(
            onTap: () => signOut(),
              child:const Icon(Icons.door_back_door_outlined))
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
          return Center(child: Text(snapshot.error.toString()),);
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else {
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
            final user = snapshot.data!.docs[index];
            return ListTile(
              title: Text(user['email'],),
              subtitle: Text(user['uid']),

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
