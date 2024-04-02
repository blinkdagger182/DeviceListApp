import 'package:authentication/screens/login_email_password_screen.dart';
import 'package:authentication/services/firebase_auth_methods.dart';
import 'package:authentication/viewmodel/device_viewmodel.dart';
import 'package:authentication/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<DeviceViewModel>(context,
        listen: false); // Set listen to false

    final user = context.read<FirebaseAuthMethods>().user;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!user.isAnonymous && user.phoneNumber == null) Text(user.email!),
          if (!user.isAnonymous && user.phoneNumber == null)
            Text(user.providerData[0].providerId),
          if (user.phoneNumber != null) Text(user.phoneNumber!),
          Text(user.uid),
          if (!user.emailVerified && !user.isAnonymous)
            CustomButton(
              onTap: () {},
              text: 'Verify Email',
            ),
          CustomButton(
            onTap: () {
              Navigator.pushNamed(context, EmailPasswordLogin.routeName);
            },
            text: 'Sign Out',
          ),
          CustomButton(
            onTap: () {
              context.read<FirebaseAuthMethods>().deleteAccount(context);
            },
            text: 'Deleted Account',
          ),
          SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
