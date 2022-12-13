import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:walkcity/src/routes/routes.dart';
//import 'ui/movie_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        // theme: ThemeData.dark(),
        // home: Scaffold(
        //   //body: MovieList(),
        // ),
        debugShowCheckedModeBanner: false,
        title: 'WalkCity',
        theme: ThemeData(
          fontFamily: GoogleFonts.nunito().fontFamily,
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: MyRoutes.generateRoute,
        initialRoute: MyRoutes.rHome,
      );
  }
}
