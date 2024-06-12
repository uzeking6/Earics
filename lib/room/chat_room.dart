import 'package:firstapp/main.dart';
import 'package:firstapp/room/join_room.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ChatProvider(),
    child: MyApp(),
  ));
}

class Chatroom extends StatefulWidget {
  const Chatroom({super.key});

  @override
  _ChatroomState createState() => _ChatroomState();
}

class _ChatroomState extends State<Chatroom> {
  final TextEditingController _messageController = TextEditingController();
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            _messageController.text = _text;
          }),
        );
      }
    } else {
      setState(() {
        _isListening = false;
      });
      _speech.stop();
    }
  }

  void _showJoinRequests() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Join Requests'),
          content: Consumer<ChatProvider>(
            builder: (context, chatProvider, child) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: chatProvider.joinRequests.map((username) {
                  return ListTile(
                    title: Text(username),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.check),
                          onPressed: () {
                            chatProvider.approveJoinRequest(username);
                            Navigator.of(context).pop();
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.close),
                          onPressed: () {
                            chatProvider.rejectJoinRequest(username);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
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
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage('https://example.com/image1.jpg'),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: NetworkImage('https://example.com/image2.jpg'),
            ),
            SizedBox(width: 8),
            CircleAvatar(
              backgroundImage: NetworkImage('https://example.com/image3.jpg'),
            ),
            SizedBox(width: 8),
            Text('Chatroom'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add),
            onPressed: _showJoinRequests,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<ChatProvider>(
              builder: (context, chatProvider, child) => ListView.builder(
                reverse: true,
                itemBuilder: (context, index) => messageBubble(
                  isCurrentUser:
                      index % 2 == 0, // Toggle between sender and receiver
                  message: chatProvider.messages[index].text,
                ),
                itemCount: chatProvider.messages.length,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                  onPressed: _listen,
                ),
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Speak now...',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (_messageController.text.isNotEmpty) {
                      Provider.of<ChatProvider>(context, listen: false)
                          .addMessage(ChatMessage(
                        username: 'Current User',
                        text: _messageController.text,
                        color: Colors.blue,
                      ));
                      _messageController.clear();
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget messageBubble({required bool isCurrentUser, required String message}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment:
            isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: isCurrentUser ? Colors.blue : Colors.grey[200],
            ),
            child: Text(message),
          ),
        ],
      ),
    );
  }
}
