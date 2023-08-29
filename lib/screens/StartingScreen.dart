// ignore_for_file: library_private_types_in_public_api, sized_box_for_whitespace, prefer_const_constructors, file_names, depend_on_referenced_packages, deprecated_member_use, avoid_print, use_build_context_synchronously

// import 'package:flutter/material.dart';
// import 'package:pdfviewer/screens/SetUp.dart';

// class StartingScreen extends StatefulWidget {
//   const StartingScreen({Key? key}) : super(key: key);

//   @override
//   _StartingScreenState createState() => _StartingScreenState();
// }

// class _StartingScreenState extends State<StartingScreen> {
//   int _currentPage = 0;
//   final PageController _pageController = PageController();

//   final List<String> featureImages = [
//     'lib/assets/pdf.png',
//     'lib/assets/collections.png',
//     'lib/assets/securepdf.png',
//   ];

//   final List<String> featureTexts = [
//     'Seamlessly create your PDF files with ease',
//     'Stay organized by using collections',
//     'Keep your PDF files secure and protected',
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             height: 200,
//             child: PageView.builder(
//               controller: _pageController,
//               itemCount: featureImages.length,
//               onPageChanged: (index) {
//                 setState(() {
//                   _currentPage = index;
//                 });
//               },
//               itemBuilder: (context, index) {
//                 return Column(
//                   children: [
//                     Image.asset(
//                       featureImages[index],
//                       height: 150,
//                     ),
//                     SizedBox(height: 20),
//                     Text(
//                       featureTexts[index],
//                       textAlign: TextAlign.center,
//                       maxLines: 2,
//                       overflow: TextOverflow.ellipsis,
//                       style:
//                           TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           ),
//           SizedBox(height: 50),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: List.generate(
//               featureImages.length,
//               (index) => Container(
//                 margin: EdgeInsets.symmetric(horizontal: 8),
//                 width: 15,
//                 height: 15,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color:
//                       _currentPage == index ? Colors.deepPurple : Colors.grey,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 70),
//           ElevatedButton(
//             onPressed: () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => SetUp()),
//               );
//             },
//             style: ElevatedButton.styleFrom(
//               primary: Colors.deepPurple,
//               onPrimary: Color.fromARGB(255, 249, 224, 253),
//               fixedSize: Size(250, 50),
//             ),
//             child: Text(
//               'Get Started',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pdfviewer/screens/SetUp.dart';

class StartingScreen extends StatefulWidget {
  const StartingScreen({Key? key}) : super(key: key);

  @override
  _StartingScreenState createState() => _StartingScreenState();
}

class _StartingScreenState extends State<StartingScreen> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  final List<String> featureImages = [
    'lib/assets/pdf.png',
    'lib/assets/collections.png',
    'lib/assets/securepdf.png',
  ];

  final List<String> featureTexts = [
    'Seamlessly create your PDF files with ease',
    'Stay organized by using collections',
    'Keep your PDF files secure and protected',
  ];

  void _launchPrivacyPolicyURL() async {
    const privacyPolicyURL = 'https://fluttergems.dev/';
    if (await canLaunch(privacyPolicyURL)) {
      await launch(privacyPolicyURL);
    } else {
      print('Could not launch $privacyPolicyURL');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 200,
            child: PageView.builder(
              controller: _pageController,
              itemCount: featureImages.length,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Image.asset(
                      featureImages[index],
                      height: 150,
                    ),
                    SizedBox(height: 20),
                    Text(
                      featureTexts[index],
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                    ),
                  ],
                );
              },
            ),
          ),
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              featureImages.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                width: 15,
                height: 15,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color:
                      _currentPage == index ? Colors.deepPurple : Colors.grey,
                ),
              ),
            ),
          ),
          SizedBox(height: 70),
          ElevatedButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => SetUp()),
              );
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Color.fromARGB(255, 249, 224, 253),
              fixedSize: Size(250, 50),
            ),
            child: Text(
              'Get Started',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
            ),
          ),
          SizedBox(height: 50),
          TextButton(
            onPressed: () {
              _launchPrivacyPolicyURL();
            },
            child: Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 16,
                color: Colors.deepPurple,
                decoration: TextDecoration.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
