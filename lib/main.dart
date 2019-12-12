import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quickly_note/ui/homepage.dart';
import 'package:provider/provider.dart';

import 'bloc/global_bloc.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.black,
    statusBarColor: Colors.black,
  ));
  runApp(QuickNotes());
}

class QuickNotes extends StatefulWidget {
  @override
  _QuickNotesState createState() => _QuickNotesState();
}

class _QuickNotesState extends State<QuickNotes> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomePage(),
        theme: ThemeData(primaryColor: Colors.black),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:quickly_note/ui/homepage.dart';
// import 'package:provider/provider.dart';

// import 'bloc/global_bloc.dart';
// import 'package:splashscreen/splashscreen.dart';

// void main() {
//   runApp(new MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: new QuickNotes(),
//   ));
// }

// class QuickNotes extends StatefulWidget {
//   @override
//   _QuickNotesState createState() => _QuickNotesState();
// }

// class _QuickNotesState extends State<QuickNotes> {
//   GlobalBloc globalBloc;

//   void initState() {
//     globalBloc = GlobalBloc();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Provider<GlobalBloc>.value(
//       value: globalBloc,
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: Splash(),
//         theme: ThemeData(primaryColor: Colors.black),
//       ),
//     );
//   }
// }

// class Splash extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return new SplashScreen(
//         seconds: 2,
//         navigateAfterSeconds: new HomePage(),
//         title: new Text(
//           'Quickly Note',
//           style: new TextStyle(
//               color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
//         ),
//         image: Image(image: AssetImage('assets/logo/QuicklySplash.png')),
//         backgroundColor: Colors.black87,
//         styleTextUnderTheLoader: new TextStyle(),
//         photoSize: 50.0,
//         loaderColor: Colors.white);
//   }
// }
