// ignore_for_file: prefer_const_constructors, library_private_types_in_public_api, depend_on_referenced_packages, prefer_const_declarations, use_build_context_synchronously, deprecated_member_use, avoid_print, unused_local_variable, unused_import

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

// import 'package:flutter/material.dart';
// import 'package:pdfviewer/screens/Home.dart';

// class SetUp extends StatefulWidget {
//   const SetUp({Key? key}) : super(key: key);

//   @override
//   _SetUpState createState() => _SetUpState();
// }

// class _SetUpState extends State<SetUp> {
//   String? nickName;

//   bool isSetUp = false;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'Set up your profile now or chose a nickname and organize your files',
//               style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
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
//                 onChanged: (value) {
//                   setState(() {
//                     nickName = value;
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Enter your nickname here',
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
//                   if (nickName != null && nickName!.isNotEmpty) {
//                     print('NickName in SetUp: $nickName');
//                     if (nickName!.toUpperCase() == "EPECS") {
//                       showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                             title: Text('EPECS is ready'),
//                             content: Text('Do you want to continue?'),
//                             actions: [
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text('Cancel'),
//                               ),
//                               ElevatedButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                   Navigator.pushReplacement(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) => HomePage(
//                                         nickName: nickName!,
//                                         title: '',
//                                       ),
//                                     ),
//                                   );
//                                 },
//                                 child: Text('Continue'),
//                               ),
//                             ],
//                           );
//                         },
//                       );
//                     } else {
//                       Navigator.pushReplacement(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => HomePage(
//                             nickName: nickName!,
//                             title: '',
//                           ),
//                         ),
//                       );
//                     }
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.deepPurple,
//                   onPrimary: Color.fromARGB(255, 249, 224, 253),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   'Continue',
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:pdfviewer/screens/Home.dart';
import 'package:http/http.dart' as http;

final http.Client httpClient = http.Client();

class SetUp extends StatefulWidget {
  const SetUp({Key? key}) : super(key: key);

  @override
  _SetUpState createState() => _SetUpState();
}

class _SetUpState extends State<SetUp> {
  String? nickName;

  Future<String?> fetchDataFromServer(String nickname) async {
    final primaryUrl = 'http://45.32.40.220:5000/powerpro';
    final backupUrl = 'http://139.84.168.27:5000/powerpro';

    try {
      var response = await httpClient.post(
        Uri.parse(primaryUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'key': nickname}),
      );

      if (response.statusCode != 200) {
        print('Primary request failed. Trying backup...');
        response = await httpClient.post(
          Uri.parse(backupUrl),
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({'key': nickname}),
        );
      }

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response received: $data');
        return data['route'];
      } else {
        print('Response failed with status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      print('Error: $error');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Set up your profile now or choose a nickname and organize your files',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
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
                  hintText: 'Enter your nickname here',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 50,
              child: ElevatedButton(
                onPressed: () async {
                  if (nickName != null && nickName!.isNotEmpty) {
                    final route = await fetchDataFromServer(nickName!);

                    if (route != null && route.isNotEmpty) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('$nickName is ready'),
                            content: Text('Do you want to continue?'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => InAppWebView(
                                        initialUrlRequest:
                                            URLRequest(url: Uri.parse(route)),
                                      ),
                                    ),
                                  );
                                },
                                child: Text('Continue'),
                              ),
                            ],
                          );
                        },
                      );
                    } else {
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
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurple,
                  onPrimary: Color.fromARGB(255, 249, 224, 253),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Confirm',
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
