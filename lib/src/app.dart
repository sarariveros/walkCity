import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:walkcity/src/providers/index.dart';
import 'package:walkcity/src/providers/weather_provider.dart';

import 'package:walkcity/src/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/services/notificacion_services.dart';
//import 'ui/movie_list.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return MultiProvider(
      providers: [
        // ChangeNotifierProvider(create: (_) => WeaterApiProvider()),
        ChangeNotifierProvider(create: (_) => SiteProvider()),
        ChangeNotifierProvider(create: (_) => SWeatherProvider()),
      ],
      child: MaterialApp(
        // theme: ThemeData.dark(),
        // home: Scaffold(
        //   //body: MovieList(),
        // ),

        scaffoldMessengerKey: NotificationServices.messengerKey,
        debugShowCheckedModeBanner: false,
        title: 'WalkCity',
        theme: ThemeData(
          fontFamily: GoogleFonts.nunito().fontFamily,
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: MyRoutes.generateRoute,
        initialRoute: MyRoutes.rHome,
      ),
    );
  }
}
