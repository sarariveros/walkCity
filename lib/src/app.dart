import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walkcity/src/providers/index.dart';
import 'package:walkcity/src/providers/map_provider.dart';
import 'package:walkcity/src/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/services/index.dart';
import 'package:walkcity/src/styles/style.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SBSite()),
        ChangeNotifierProvider(create: (_) => ProviderLogin()),
        ChangeNotifierProvider(
          create: (_) => SBFavorite(),
        ),
        ChangeNotifierProvider(
          create: (_) => AuthService(),
        ),
        ChangeNotifierProvider(
          create: (_) => StorageImageProvider(),
        ),
        ChangeNotifierProvider(create: (_) => MapProvider()),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: NotificationServices.messengerKey,
        debugShowCheckedModeBanner: false,
        title: 'WalkCity',
        theme: ThemeData(
          colorScheme: ColorScheme(
              brightness: Brightness.light,
              primary: Colors.white,
              onPrimary: Colors.black,
              secondary: Colors.white,
              onSecondary: Colors.white,
              error: Colors.white,
              onError: Colors.white,
              background: Colors.white,
              onBackground: Colors.white,
              surface: Styles.firstColor,
              onSurface: Colors.white),
          fontFamily: GoogleFonts.nunito().fontFamily,
          useMaterial3: true,
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: MyRoutes.generateRoute,
        initialRoute: MyRoutes.rVerify,
      ),
    );
  }
}
