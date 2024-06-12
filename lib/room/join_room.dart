import 'dart:math';
import 'package:firstapp/room/chat_room.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ChatMessage {
  final String username;
  final String text;
  final Color color;

  ChatMessage(
      {required this.username, required this.text, required this.color});
}

class ChatProvider with ChangeNotifier {
  final List<ChatMessage> _messages = [];
  final List<String> _joinRequests = [];
  final List<String> _participants = [];

  String currentUsername = '';
  List<ChatMessage> get messages => _messages;
  List<String> get joinRequests => _joinRequests;
  List<String> get participants => _participants;

  void addMessage(ChatMessage message) {
    _messages.add(message);
    notifyListeners();
  }

  void addJoinRequest(String enteredUsername) {
    _joinRequests.add(enteredUsername);
    notifyListeners();
  }

  void approveJoinRequest(String username) {
    _joinRequests.remove(username);
    _participants.add(username);
    notifyListeners();
  }

  void rejectJoinRequest(String username) {
    _joinRequests.remove(username);
    notifyListeners();
  }
}

class JoinRoom extends StatefulWidget {
  const JoinRoom({super.key});

  @override
  State<JoinRoom> createState() => _JoinRoomState();
}

class _JoinRoomState extends State<JoinRoom> {
  late String _meetingCode;

  @override
  void initState() {
    super.initState();
    _meetingCode = _generateMeetingCode();
  }

  String _generateMeetingCode() {
    final random = Random();
    const String alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final meetingCode =
        List.generate(3, (_) => alphabet[random.nextInt(alphabet.length)])
                .join('') +
            List.generate(4, (_) => random.nextInt(10)).join('');
    return meetingCode;
  }

  void _showJoinMeetingDialog() {
    String enteredCode = '';
    String enteredUsername = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Join Meeting'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  enteredUsername = value;
                },
                decoration: const InputDecoration(hintText: "Enter Username"),
              ),
              TextField(
                onChanged: (value) {
                  enteredCode = value;
                },
                decoration:
                    const InputDecoration(hintText: "Enter Meeting Code"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                if (enteredCode == _meetingCode) {
                  Provider.of<ChatProvider>(context, listen: false)
                      .addJoinRequest(enteredUsername);
                }
              },
              child: const Text('Request to Join'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void _showCodeOptionsDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Meeting Code Options'),
          content: const Text(
              'Would you like to copy the code or join the meeting?'),
          actions: [
            TextButton(
              onPressed: () {
                Clipboard.setData(ClipboardData(text: _meetingCode));
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text('Meeting code copied to clipboard')),
                );
              },
              child: const Text('Copy Code'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                      create: (_) => ChatProvider(),
                      child: const Chatroom(),
                    ),
                  ),
                );
              },
              child: const Text('Join Meeting'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Earics Meet'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to Earics Meet',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Text(
              'Meeting Code:',
              style: TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: _showCodeOptionsDialog,
              child: Text(
                _meetingCode,
                style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _meetingCode = _generateMeetingCode();
                });
              },
              child: const Text('Generate New Code'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showJoinMeetingDialog,
              child: const Text('Join Meeting'),
            ),
          ],
        ),
      ),
    );
  }
}
