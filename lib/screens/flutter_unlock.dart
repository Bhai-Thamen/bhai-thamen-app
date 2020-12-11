// import 'package:bhaithamen/utilities/auto_page_navigation.dart';
// import 'package:bhaithamen/utilities/variables.dart';
// import 'package:flutter/material.dart';
// import 'package:local_auth/local_auth.dart';
// import 'package:provider/provider.dart';

// import 'package:flutter/services.dart';

// import 'package:key_guardmanager/key_guardmanager.dart';

// class MyAuth extends StatefulWidget {
//   @override
//   _MyAuthState createState() => _MyAuthState();
// }

// class _MyAuthState extends State<MyAuth> {

//   String _checkAuth = 'false';

//   @override
//   void initState() {
//     super.initState();
//     if (usePincode==true)initPlatformState();
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initPlatformState() async {
//     String platformAuth;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       platformAuth = await KeyGuardmanager.authStatus;
    
//     } on PlatformException {
//       platformAuth = 'Failed to get platform auth.';
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     if (!mounted) return;

//     setState(() {
//       _checkAuth = platformAuth;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Plugin example app'),
//         ),
//         body: Center(
//           child: Text('Running on: $_checkAuth\n'),
//         ),
//       ),
//     );
//   }
// }