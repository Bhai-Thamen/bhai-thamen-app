// import 'package:flutter/material.dart';

// class SecretScreen extends StatefulWidget {
//   @override
//   _SecretScreenState createState() => _SecretScreenState();
// }

// List selectedLanguage = ['english','bangla'];
// int languageIndex=0;

// Map<String,dynamic> english =  {
//   'language': 'English',
//   'text1': 'red',
//   'text2': 'green'
// };

// Map<String,dynamic> bangla =  {
//   'language': 'বাংলা',
//   'text1': 'লাল',
//   'text2': 'সবুজ'
// };

// Map<dynamic,dynamic> languages = {
//   'english': english,
//   'bangla': bangla
// };

// class _SecretScreenState extends State<SecretScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child:
//       Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               FlatButton(
//                 onPressed: (){
//                   setState(() {
//                     languageIndex=0;
//                   });
//                 },
//                 child: Text(languages[selectedLanguage[0]]['language']),
//                 ),
//               FlatButton(
//                 onPressed: (){
//                   setState(() {
//                     languageIndex=1;
//                   });
//                 },
//                 child: Text(languages[selectedLanguage[1]]['language']),
//                 ),            
//             ],
//           ),
//           Text(languages[selectedLanguage[languageIndex]]['text1']),
//           Text(languages[selectedLanguage[languageIndex]]['text2'])
//         ],
//       ),
//     );
//   }
// }