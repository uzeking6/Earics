import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ASL Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignLanguageScreen(),
    );
  }
}

class SignLanguageScreen extends StatefulWidget {
  const SignLanguageScreen({super.key});

  @override
  _SignLanguageScreenState createState() => _SignLanguageScreenState();
}

class _SignLanguageScreenState extends State<SignLanguageScreen> {
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
      bool available = await _speech.initialize();
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (result) => setState(() {
            _text = result.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _convertToASL() {
    // Dummy ASL translation for demonstration
    String aslTranslation = "This is where ASL translation would happen.";
    // Implement ASL translation logic here
    _showASLDialog(aslTranslation);
  }

  void _showASLDialog(String aslTranslation) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ASL Translation'),
          content: Text(aslTranslation),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
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
        title: const Text('ASL Converter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text),
            ElevatedButton(
              onPressed: _listen,
              child: Icon(_isListening ? Icons.mic : Icons.mic_none),
            ),
            ElevatedButton(
              onPressed: _convertToASL,
              child: const Text('Convert to ASL'),
            ),
          ],
        ),
      ),
    );
  }
}










// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:flutter_tts/flutter_tts.dart';

// class SignLanguageScreen extends StatefulWidget {
//   const SignLanguageScreen({super.key});

//   @override
//   _SignLanguageScreenState createState() => _SignLanguageScreenState();
// }

// class _SignLanguageScreenState extends State<SignLanguageScreen> {
//   final stt.SpeechToText _speechToText = stt.SpeechToText();
//   final FlutterTts _flutterTts = FlutterTts();
//   String _recognizedSpeech = '';
//   final Map<String, String> _wordToSignText = {
//     'hello': '👋 (wave hand)',
//     'world': '🌍 (rotate hand around)',
//     // Add more word-to-sign mappings here
//   };
//   List<String> _recognizedWords = [];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Sign Language Translator'),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             ElevatedButton(
//               onPressed: _startListening,
//               child: const Text('Start Listening'),
//             ),
//             const SizedBox(height: 20),
//             Text(_recognizedSpeech),
//             const SizedBox(height: 20),
//             ElevatedButton(
//               onPressed: () {
//                 _speakText(_recognizedSpeech);
//               },
//               child: const Text('Speak Text'),
//             ),
//             const SizedBox(height: 20),
//             _buildSignLanguageDisplay(),
//           ],
//         ),
//       ),
//     );
//   }

//   void _startListening() async {
//     bool available = await _speechToText.initialize();
//     if (available) {
//       _speechToText.listen(
//         onResult: (result) {
//           setState(() {
//             _recognizedSpeech = result.recognizedWords;
//             _recognizedWords = _recognizedSpeech.split(' ');
//           });
//         },
//       );
//     } else {
//       print('Speech recognition not available');
//     }
//   }

//   void _speakText(String text) async {
//     await _flutterTts.speak(text);
//   }

//   Widget _buildSignLanguageDisplay() {
//     return Wrap(
//       children: _recognizedWords.map((word) {
//         String? signText = _wordToSignText[word.toLowerCase()];
//         if (signText != null) {
//           return Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               signText,
//               style: const TextStyle(fontSize: 24),
//             ),
//           );
//         } else {
//           return Container();
//         }
//       }).toList(),
//     );
//   }
// }
