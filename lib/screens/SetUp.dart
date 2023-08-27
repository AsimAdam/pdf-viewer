// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, depend_on_referenced_packages, prefer_const_declarations, use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:pdfviewer/screens/Home.dart';

// class SetUp extends StatefulWidget {
//   const SetUp({Key? key}) : super(key: key);

//   @override
//   _SetUpState createState() => _SetUpState();
// }

// class _SetUpState extends State<SetUp> {
//   String? keyInput;
//   String recoveryCode = '123456';

//   bool isKeySetUp = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Set up your key now to protect your files',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 50),
//             Container(
//               width: MediaQuery.of(context).size.width * 0.9,
//               height: 60,
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               decoration: BoxDecoration(
//                 border: Border.all(color: Colors.grey),
//                 borderRadius: BorderRadius.circular(8),
//               ),
//               child: TextFormField(
//                 obscureText: true,
//                 onChanged: (value) {
//                   setState(() {
//                     keyInput = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Enter your key',
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             SizedBox(
//               width: MediaQuery.of(context).size.width * 0.9,
//               height: 50,
//               child: ElevatedButton(
//                 onPressed: () {
//                   if (isKeySetUp) {
//                     Navigator.pushReplacement(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => HomePage(title: '')),
//                     );
//                   } else {
//                     setState(() {
//                       isKeySetUp = true;
//                     });
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   isKeySetUp ? 'Continue' : 'Confirm',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                 ),
//               ),
//             ),
//             if (isKeySetUp && keyInput != null && keyInput!.isNotEmpty)
//               Padding(
//                 padding: EdgeInsets.only(top: 16),
//                 child: TextButton(
//                   onPressed: () {
//                     showDialog(
//                       context: context,
//                       builder: (BuildContext context) {
//                         return AlertDialog(
//                           title: Text('Recovery Code'),
//                           content: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Text('Your recovery code: $recoveryCode'),
//                               IconButton(
//                                 onPressed: () {},
//                                 icon: Icon(Icons.copy),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     );
//                   },
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all<Color>(Colors.transparent),
//                     padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
//                         EdgeInsets.zero),
//                     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     side:
//                         MaterialStateProperty.all<BorderSide>(BorderSide.none),
//                   ),
//                   child: Text(
//                     'Show Recovery Code',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.w700,
//                       color: Colors.deepPurple,
//                     ),
//                   ),
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:pdfviewer/screens/Home.dart';

class SetUp extends StatefulWidget {
  const SetUp({Key? key}) : super(key: key);

  @override
  _SetUpState createState() => _SetUpState();
}

class _SetUpState extends State<SetUp> {
  String? nickName;

  bool isSetUp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Set up your profile',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 50),
            Container(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: TextFormField(
                onChanged: (value) {
                  setState(() {
                    nickName = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Enter your nick name',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  if (nickName != null && nickName!.isNotEmpty) {
                    print('NickName in SetUp: $nickName');
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomePage(
                          nickName: nickName!,
                          title: '',
                        ),
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  isSetUp ? 'Continue' : 'Confirm',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
