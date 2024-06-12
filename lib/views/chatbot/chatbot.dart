import 'package:flutter/material.dart';
import 'package:google_gemini/google_gemini.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:math';
import 'package:firstapp/views/chatbot/onboarding.dart';

class ChatBot extends StatefulWidget {
  final String msg;

  const ChatBot({super.key, required this.msg});

  @override
  State<ChatBot> createState() => _ChatBotState();
}

class _ChatBotState extends State<ChatBot> {
  bool loading = false;
  List<Map<String, String>> textChat = [];
  List<Map<String, String>> textWithImageChat = [];
  List<Map<String, String>> suggestedQuestions = [];
  final Set<int> usedIndices = <int>{};

  final TextEditingController _textController = TextEditingController();
  final ScrollController _controller = ScrollController();
  final ImagePicker _picker = ImagePicker();

  late final GoogleGemini gemini;

  @override
  void initState() {
    super.initState();
    String? apiKey = 'AIzaSyD4OzWQYvpNZ868dni6XX7Hbk9LcyiNYpo';
    gemini = GoogleGemini(apiKey: apiKey);

    if (widget.msg.isNotEmpty) {
      // If a message is provided, send it as the first query
      fromText(query: widget.msg);
    }

    generateSuggestedQuestions();
  }

  @override
  void dispose() {
    // Dispose the controllers when the widget is disposed
    _textController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void fromText({required String query}) {
    setState(() {
      loading = true;
      textChat.add({
        "role": "User",
        "text": query,
      });
      _textController.clear();
    });
    scrollToTheEnd();

    gemini.generateFromText(query).then((value) {
      setState(() {
        loading = false;
        textChat.add({
          "role": "Gemini",
          "text": value.text,
        });
      });
      scrollToTheEnd();
    }).onError((error, stackTrace) {
      setState(() {
        loading = false;
        textChat.add({
          "role": "Gemini",
          "text": error.toString(),
        });
      });
      scrollToTheEnd();
    });
  }

  void scrollToTheEnd() {
    if (_controller.hasClients) {
      _controller.animateTo(
        _controller.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        textChat.add({
          "role": "User",
          "text": "User sent an image",
        });
        textWithImageChat.add({
          "image": pickedFile.path,
        });
      });
      scrollToTheEnd();
    }
  }

  void generateSuggestedQuestions() {
    final questionsPool = [
      {"question": "What are the symptoms of diabetes?", "icon": "💉"},
      {"question": "How can I lower my blood pressure?", "icon": "🩺"},
      {
        "question": "What are the best exercises for weight loss?",
        "icon": "🏋️"
      },
      {"question": "What is a healthy diet?", "icon": "🍎"},
      {"question": "How much sleep do I need?", "icon": "😴"},
      {"question": "What is the best way to quit smoking?", "icon": "🚬"},
      {"question": "What are the benefits of regular exercise?", "icon": "🏃"},
      {"question": "How can I manage stress effectively?", "icon": "🧘"},
      {"question": "What are the signs of a heart attack?", "icon": "❤️"},
      {"question": "How to improve mental health?", "icon": "🧠"},
    ];

    final random = Random();
    final selectedQuestions = <Map<String, String>>[];

    while (selectedQuestions.length < 5 &&
        usedIndices.length < questionsPool.length) {
      int index = random.nextInt(questionsPool.length);
      if (!usedIndices.contains(index)) {
        usedIndices.add(index);
        selectedQuestions.add(questionsPool[index]);
      }
    }

    setState(() {
      suggestedQuestions = selectedQuestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health ChatBot"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const Onboarding()),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller, //  the controller ATTACH here
              itemCount: textChat.length,
              padding: const EdgeInsets.only(bottom: 20),
              itemBuilder: (context, index) {
                if (textWithImageChat.length > index &&
                    textWithImageChat[index].containsKey("image")) {
                  return ListTile(
                    leading: CircleAvatar(
                      child: Text(
                        textChat[index]["role"]!.substring(0, 1),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      textChat[index]["role"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Image.file(
                      File(textWithImageChat[index]["image"]!),
                      height: 100,
                    ),
                  );
                } else {
                  return ListTile(
                    isThreeLine: true,
                    leading: CircleAvatar(
                      child: Text(
                        textChat[index]["role"]!.substring(0, 1),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      textChat[index]["role"]!,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(textChat[index]["text"]!),
                  );
                }
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              border: Border.all(color: Colors.grey),
            ),
            child: Column(
              children: [
                Wrap(
                  spacing: 10,
                  children: suggestedQuestions.map((question) {
                    return ElevatedButton.icon(
                      icon: Text(question["icon"]!),
                      label: Text(question["question"]!),
                      onPressed: () {
                        fromText(query: question["question"]!);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    );
                  }).toList(),
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.image),
                      onPressed: _pickImage,
                    ),
                    Expanded(
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          hintText: "Type a message",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide.none,
                          ),
                          fillColor: Colors.transparent,
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                      ),
                    ),
                    IconButton(
                      icon: loading
                          ? const SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.send),
                      onPressed: () {
                        if (_textController.text.isNotEmpty && !loading) {
                          fromText(query: _textController.text);
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
