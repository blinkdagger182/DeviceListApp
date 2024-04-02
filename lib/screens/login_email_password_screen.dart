import 'package:authentication/main.dart';
import 'package:authentication/screens/home_screen.dart';
import 'package:authentication/services/firebase_auth_methods.dart';
import 'package:authentication/utils/showSnackbar.dart';
import 'package:authentication/widgets/custom_button.dart';
import 'package:authentication/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EmailPasswordLogin extends StatefulWidget {
  static String routeName = '/login-email-password';
  const EmailPasswordLogin({Key? key}) : super(key: key);

  @override
  _EmailPasswordLoginState createState() => _EmailPasswordLoginState();
}

class _EmailPasswordLoginState extends State<EmailPasswordLogin> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void loginUser() async {
    String loginResult = await FirebaseAuthMethods().loginWithEmail(
      email: emailController.text,
      password: passwordController.text,
      context: context,
    );

    if (loginResult == 'Success') {
      print('loginResult ${loginResult}');
      showSnackBar(context, 'Successfully');
      Navigator.pushReplacementNamed(context, BottomNavBar.routeName);
    } else {
      showSnackBar(context, 'Login failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Login",
            style: TextStyle(fontSize: 30),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.08),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: emailController,
              hintText: 'Enter your email',
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: CustomTextField(
              controller: passwordController,
              hintText: 'Enter your password',
            ),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: loginUser,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              textStyle: MaterialStateProperty.all(
                const TextStyle(color: Colors.white),
              ),
              minimumSize: MaterialStateProperty.all(
                Size(MediaQuery.of(context).size.width / 2.5, 50),
              ),
            ),
            child: const Text(
              "Login",
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          const SizedBox(height: 16),
          CustomButton(
            onTap: () {
              context.read<FirebaseAuthMethods>().signInWithGoogle(context);
            },
            text: 'Google Sign In',
          ),
        ],
      ),
    );
  }
}
