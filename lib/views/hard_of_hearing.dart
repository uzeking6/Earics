import 'package:avatar_glow/avatar_glow.dart';
import 'package:firstapp/views/profile_page.dart';
import 'package:firstapp/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:flutter_tts/flutter_tts.dart';

class HardHearing extends StatefulWidget {
  const HardHearing({super.key, required this.title});
  final String title;

  @override
  _HardHearingState createState() => _HardHearingState();
}

class _HardHearingState extends State<HardHearing> {
  var height, width;
  var islistening = false;
  String profileName = "ursulla";
  final FlutterTts flutterTts = FlutterTts();
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool _isListening = false;
  String _text = '';
  final String _profileName = "Ursulla"; // Updated profile name

  // Controller for the text input field
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initTts();
  }

  void _initTts() async {
    await flutterTts.setLanguage('en-GB');
  }

  void _toggleListening() async {
    if (!_isListening) {
      // initializing text to speech engine
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      // checking if speech recognition is available on the device
      if (available) {
        setState(() {
          _isListening = true;
        });

        //start listeninng for speech
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords ?? '';
          }),
        );
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
      });
    }
  }

  Future<void> _speak(String text) async {
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        color: const Color.fromRGBO(60, 193, 177, 1),
        height: height,
        width: width,
        child: Column(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Color.fromRGBO(60, 193, 177, 1),
              ),
              height: height * 0.25,
              width: width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 55,
                      left: 15,
                      right: 15,
                    ),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return const ProfilePage();
                              },
                            ));
                          },
                          child: Column(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                child: Icon(
                                  Icons.person_2_rounded,
                                  size: 40,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                profileName,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) {
                                    return const Settings();
                                  },
                                ));
                              },
                              child: const Icon(
                                Icons.settings,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      // top: 25,
                      left: 15,
                      right: 15,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(30.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              height: height * 0.75,
              width: width,
              child: Column(
                children: [
                  // Adding an Expanded widget around the TextField to make it fill the available space
                  Expanded(
                    child: TextField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText: 'Enter text to speak...',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        // Updating the _text variable with the text from the input field
                        _text = value;
                      },
                      maxLines:
                          null, // Setting maxLines to null for multi-line input
                    ),
                  ),
                  const SizedBox(
                      height:
                          20), // Adding some space between the text field and other widgets
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(
            width: 40,
          ),
          FloatingActionButton(
            onPressed: () {
              _speak(_text);
            },
            child: const Icon(Icons.volume_up),
          ),
          const SizedBox(width: 16),
          AvatarGlow(
            animate: islistening,
            duration: const Duration(milliseconds: 2000),
            glowColor: const Color.fromRGBO(60, 193, 177, 1),
            repeat: true,
            child: GestureDetector(
              onTap: () {
                _toggleListening(); // Toggle speech-to-text
              },
              child: CircleAvatar(
                backgroundColor: const Color.fromRGBO(60, 193, 177, 1),
                radius: 35,
                child: Icon(
                  islistening ? Icons.mic : Icons.mic_none,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(
            width: 150,
          ),
        ],
      ),
    );
  }
}
