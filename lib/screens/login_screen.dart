import 'package:authentication/screens/login_email_password_screen.dart';
import 'package:authentication/screens/phone_screen.dart';
import 'package:authentication/screens/signup_email_password_screen.dart';
import 'package:authentication/services/firebase_auth_methods.dart';
import 'package:authentication/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firebase Auth Demo'),
        elevation: 5,
        leading: const Icon(IconlyBold.lock),
        centerTitle: true,
        forceMaterialTransparency: false,
      ),
      body: CustomScrollView(
        primary: false,
        slivers: <Widget>[
          SliverPadding(
            padding: const EdgeInsets.all(30),
            sliver: SliverGrid.count(
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              crossAxisCount: 2,
              children: <Widget>[
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, EmailPasswordSignup.routeName);
                  },
                  text: 'Email/Password Sign Up',
                ),
                CustomButton(
                    onTap: () {
                      Navigator.pushNamed(context, PhoneScreen.routeName);
                    },
                    text: 'Phone Sign In'),
                CustomButton(
                  onTap: () {
                    Navigator.pushNamed(context, EmailPasswordLogin.routeName);
                  },
                  text: 'Email/Password Login',
                ),
                CustomButton(
                  onTap: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .signInWithGoogle(context);
                  },
                  text: 'Google Sign In',
                ),
                CustomButton(
                  onTap: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .signInWithFacebook(context);

                    // FirebaseAuthMethods().signInWithFacebook(context);
                  },
                  text: 'Facebook Sign In',
                ),
                CustomButton(
                  onTap: () {
                    context
                        .read<FirebaseAuthMethods>()
                        .signInAnonymously(context);

                    // FirebaseAuthMethods().signInAnonymously(context);
                  },
                  text: 'Anonymous Sign In',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
