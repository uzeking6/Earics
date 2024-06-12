import 'package:flutter/material.dart';
import 'package:firstapp/views/register.dart';
import 'package:firstapp/views/reset_password_send_request.dart';
import 'package:firstapp/constants/constants.dart';
import 'package:firstapp/models/button.dart';
// import 'package:url_launcher/url_launcher.dart';

class ChoiceScreen extends StatefulWidget {
  const ChoiceScreen({super.key});

  @override
  State<ChoiceScreen> createState() => _ChoiceScreenState();
}

class _ChoiceScreenState extends State<ChoiceScreen> {
  final bool _isPasswordVisible = false;

  double screenHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const Center(
                  child: Text(
                    "Hello!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        fontFamily: 'Roboto'),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.11,
                ),
                const Text("Sign in with your username or phone number"),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 10, right: 5),
                      child: Icon(
                        Icons.email,
                        color: Color.fromRGBO(60, 193, 177, 1),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: const BorderSide(color: Colors.green),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 10, right: 5),
                      child: Icon(
                        Icons.lock,
                        color: Color(0xFF348E2B),
                      ),
                    ),
                    suffixIcon: const Icon(
                      Icons.visibility,
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: const BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(60, 193, 177, 1),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.09,
                ),
                Button(
                  text: "Sign In",
                  onPressed: () {},
                  width: screenHeight(context) * 0.5,
                  color: const Color.fromRGBO(60, 193, 177, 1),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.02,
                ),
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Text("Create account."),
                        InkWell(
                          child: const Text(
                            "Register?",
                            style: TextStyle(
                                color: Colors.green,
                                decoration: TextDecoration.underline),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Register(
                                          title: 'register',
                                        )));
                          },
                        ),
                        const SizedBox(
                          width: 45,
                        ),
                        InkWell(
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(
                                color: Colors.green,
                                decoration: TextDecoration.underline),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Reset1()));
                          },
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                const Center(
                  child: Text(
                    "or continue with",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.05,
                ),
                Row(
                  children: [
                    InkWell(
                      child: CircleAvatar(
                        child: Image.asset("assets/images/google.png"),
                      ),
                    ),
                    const Text("Google"),
                    SizedBox(
                      width: screenHeight(context) * 0.15,
                    ),
                    InkWell(
                      child: CircleAvatar(
                        child: Image.asset("assets/images/facebook.png"),
                      ),
                    ),
                    const Text("Facebook")
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
