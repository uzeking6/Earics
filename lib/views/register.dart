import 'package:flutter/material.dart';
import 'package:firstapp/constants/constants.dart';
import 'package:firstapp/models/button.dart';
import 'package:firstapp/views/radio_screen.dart';
import 'package:url_launcher/url_launcher.dart';

final _formKey = GlobalKey<FormState>();

class Register extends StatefulWidget {
  const Register({super.key, required String title});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isPasswordVisible = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _isPasswordVisible = false;
  }

  String? validatePassword(String? value) {
    if (value!.isEmpty) {
      return "Please enter a password";
    } else if (value.length < 6) {
      return "Password must be at least 6 characters long";
    }
    return null;
  }

  String? validateEmail(String? email) {
    RegExp emailRegex = RegExp(r'^[\w\.-]+@[\w-]+\.\w{2,3}(\.\w{2,3})?$');
    final isEmailValid = emailRegex.hasMatch(email ?? '');
    if (!isEmailValid) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateName(String? name) {
    if (name == null || name.isEmpty) {
      return 'Please enter your name';
    } else if (name.length < 3) {
      return 'Name should be at least 3 characters long';
    }
    return null;
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RadioScreen(title: ''),
                        ),
                      );
                    },
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'skip',
                          style: TextStyle(
                            decoration: TextDecoration.none,
                            decorationColor: Color.fromRGBO(122, 198, 189, 1),
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            fontSize: 20.0,
                            color: Color.fromRGBO(122, 198, 189, 1),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromRGBO(122, 198, 189, 1),
                          size: 20.0,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.1,
                ),
                const Center(
                  child: Text(
                    "Sign Up!",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 40,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                const Text("Sign in with your username or phone number"),
                SizedBox(
                  height: screenHeight(context) * 0.03,
                ),
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: "Name",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(60, 193, 177, 100),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(60, 193, 177, 100),
                      ),
                    ),
                  ),
                  validator: validateName,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(60, 193, 177, 100),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(60, 193, 177, 100),
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: validateEmail,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: _passwordController,
                  obscureText: _isPasswordVisible,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    filled: true,
                    fillColor: Colors.white,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(60, 193, 177, 100),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(13),
                      borderSide: const BorderSide(
                        color: Color.fromRGBO(60, 193, 177, 100),
                      ),
                    ),
                  ),
                  validator: validatePassword,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                ),
                SizedBox(
                  height: screenHeight(context) * 0.07,
                ),
                Button(
                  text: "Sign Up",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Perform sign-up logic here
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const RadioScreen(title: 'register'),
                        ),
                      );
                    }
                  },
                  width: screenHeight(context) * 0.5,
                  color: const Color.fromRGBO(60, 193, 177, 100),
                ),
                SizedBox(
                  height: screenHeight(context) * 0.02,
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
                  height: screenHeight(context) * 0.03,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        _launchURL("https://accounts.google.com/signin");
                      },
                      child: CircleAvatar(
                        radius: 15, // Adjust the radius as needed
                        child: ClipOval(
                          child: Image.asset(
                            "lib/assets/google.png",
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    ),
                    const Text("Google"),
                    SizedBox(
                      width: screenHeight(context) * 0.15,
                    ),
                    InkWell(
                      onTap: () {
                        _launchURL("https://www.facebook.com/login");
                      },
                      child: CircleAvatar(
                        radius: 15, // Adjust the radius as needed
                        child: ClipOval(
                          child: Image.asset(
                            "lib/assets/facebook.png",
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                          ),
                        ),
                      ),
                    ),
                    const Text("Facebook"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
