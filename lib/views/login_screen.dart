import 'package:flutter/material.dart';
import 'package:firstapp/room/join_room.dart';
import '../models/button.dart';
import 'register.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key, required String title});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const JoinRoom()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(top: 50, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Join Room',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      decorationColor: Color.fromRGBO(122, 198, 189, 1),
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500,
                      fontSize: 20.0,
                      color: Color.fromRGBO(122, 198, 189, 1),
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward,
                    color: Color.fromRGBO(122, 198, 189, 1),
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 130, horizontal: 25),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "lib/assets/image.png",
                      height: screenHeight * 0.3,
                    ),
                    const SizedBox(height: 30),
                    Center(
                      child: const Text(
                        "Welcome to Earics! Your one-stop for communication and collaboration ",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 80),
                    Button(
                      text: "Get Started with earics",
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const Register(title: 'register'),
                        ));
                      },
                      width: screenHeight * 0.5,
                      color: const Color.fromRGBO(60, 193, 177, 100),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
