import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

FirebaseOptions? logeduser;
final firestore = FirebaseFirestore.instance;
String messagetext = 'Hello';

class RoundedButton extends StatelessWidget {
  const RoundedButton(
      {super.key, this.color, this.title, required this.onPressed});
  final Color? color;
  final String? title;
  final Function? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: () {
            onPressed!.call();
          },
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title.toString(),
          ),
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.text, required this.sender});
  final String text;
  final String sender;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            sender,
            style: const TextStyle(fontSize: 10, color: Colors.grey),
          ),
          Material(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            elevation: 5,
            color: Colors.lightBlueAccent,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              child: Text(
                text,
                style: const TextStyle(fontSize: 15, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MessageStream extends StatelessWidget {
  const MessageStream({super.key});

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    return StreamBuilder<QuerySnapshot>(
      stream: firestore.collection('messages').snapshots(),
      builder: (context, snapshot) {
        List<MessageBubble> messageBubbles = [];
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        if (snapshot.data != null) {
          final message = snapshot.data!.docs;

          for (var messages in message) {
            try {
              final messageText = messages.get('text');
              final messageSender = messages.get('Sender');
              final messageBubble = MessageBubble(
                sender: messageSender.toString(),
                text: messageText,
              );
              messageBubbles.add(messageBubble);
            } catch (e) {
              print(e);
            }
          }
        }

        return Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            children: messageBubbles,
          ),
        );
      },
    );
  }
}

void getnewjoin() async {
  FirebaseOptions? logeduser;
  final _auth = FirebaseAuth.instance;
  try {
    final user = await _auth.currentUser;
    if (user != null) {
      logeduser != user;
    }
  } catch (e) {
    print(e);
  }
}

void getStream() async {
  final firestore = FirebaseFirestore.instance;

  await for (var snapshot in firestore.collection('messages').snapshots()) {
    for (var messages in snapshot.docs) {
      print(messages.data());
    }
  }
}
