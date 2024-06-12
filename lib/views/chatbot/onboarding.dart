import 'package:firstapp/views/chatbot/chatbot.dart';
import 'package:firstapp/views/radio_screen.dart';
import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => const RadioScreen(
                        title: '',
                      )),
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Column(
              children: [
                Text(
                  'Earics AI Assistant',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(60, 193, 177, 1),
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                Text(
                  'Using this, you can ask your health questions and receive articles using artificial intelligence assistant',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black54),
                )
              ],
            ),
            const SizedBox(
              height: 32,
            ),
            Image.asset('lib/assets/image.png'),
            const SizedBox(
              height: 32,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ChatBot(
                                msg: '',
                              )),
                      (route) => false);
                },
                style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding:
                        const EdgeInsets.symmetric(vertical: 16, horizontal: 32)),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Continue',
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Icon(Icons.arrow_forward)
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
