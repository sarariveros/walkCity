import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:walkcity/src/providers/index.dart';
import 'package:walkcity/src/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/services/notificacion_services.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SiteProvider()),
        ChangeNotifierProvider(create: (_) => ProviderLogin()),
        ChangeNotifierProvider(create: (_) => AuthService(),),
        ChangeNotifierProvider(create: (_) => StorageImageProvider(),),
      ],
      child: MaterialApp(
        scaffoldMessengerKey: NotificationServices.messengerKey,
        debugShowCheckedModeBanner: false,
        title: 'WalkCity',
        theme: ThemeData(
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
