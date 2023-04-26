import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:watcher_app/screens/welcome/welcome_screen.dart';
import 'package:watcher_app/screens/location/location_screen.dart';

class TopBar extends StatelessWidget with PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Watcher App'),
      actions: [
        IconButton(
          icon: const Icon(Icons.location_on),
          onPressed: () {
            //  const Expanded(flex: 4, child: LocationScreen());
          },
        ),
        IconButton(
          icon: const Icon(Icons.qr_code_scanner),
          onPressed: () {
            // MaterialPageRoute(builder: (context) => const qrcode_scanner()),
          },
        ),
        IconButton(
          icon: const Icon(Icons.logout),
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WelcomeScreen()),
            );
          },
        ),
      ],
    );
  }
}
