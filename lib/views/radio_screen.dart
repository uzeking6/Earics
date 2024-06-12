import 'package:firstapp/views/chatbot/onboarding.dart';
import 'package:firstapp/views/hard_of_hearing.dart';
import 'package:firstapp/views/signlan/sign_language_screen.dart';
import 'package:flutter/material.dart';

class RadioScreen extends StatefulWidget {
  const RadioScreen({super.key, required this.title});
  final String title;

  @override
  _RadioScreenState createState() => _RadioScreenState();
}

class _RadioScreenState extends State<RadioScreen> {
  var height, width;

  String selectedSnack = 'None selected';

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
              child: const Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'How do you identify yourself?',
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 25.0,
                      color: Colors.white,
                    ),
                  ),
                ),
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
                  const SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: const BorderRadius.all(Radius.circular(13)),
                    ),
                    child: SizedBox(
                      child: RadioMenuButton(
                        value: 'I am Deaf and use sign language',
                        groupValue: selectedSnack,
                        onChanged: (selectedValue) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignLanguageScreen(),
                            ),
                          );
                          setState(() => selectedSnack = selectedValue!);
                        },
                        child: const Text(
                          'I am Deaf and use sign language',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: const BorderRadius.all(Radius.circular(13)),
                    ),
                    child: SizedBox(
                      child: RadioMenuButton(
                        value: 'I am Deaf / Hard-of-Hearing',
                        groupValue: selectedSnack,
                        onChanged: (selectedValue) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HardHearing(
                                title: 'register',
                              ),
                            ),
                          );
                          setState(() => selectedSnack = selectedValue!);
                        },
                        child: const Text(
                          'I am Deaf / Hard-of-Hearing',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.green),
                      borderRadius: const BorderRadius.all(Radius.circular(13)),
                    ),
                    child: SizedBox(
                      child: RadioMenuButton(
                        value: 'I can hear well',
                        groupValue: selectedSnack,
                        onChanged: (selectedValue) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Onboarding(),
                            ),
                          );
                          setState(() => selectedSnack = selectedValue!);
                        },
                        child: const Text(
                          'I can hear well',
                          style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
