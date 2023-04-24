// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';

// Future<void> signOut() async {
//   await FirebaseAuth.instance.signOut();
// }

// class Sidebar extends StatelessWidget {
//   const Sidebar({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Drawer(
//       child: ListView(
//         padding: EdgeInsets.zero,
//         children: <Widget>[
//           const DrawerHeader(
//             decoration: BoxDecoration(
//               color: Colors.blue,
//             ),
//             child: Text('Sidebar'),
//           ),
//           ListTile(
//             title: Text('Sign out'),
//             onTap: () {
//               signOut();
//               Navigator.pop(context);
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
