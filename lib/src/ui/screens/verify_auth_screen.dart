import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/routes/routes.dart';
import 'package:walkcity/src/services/service_auth.dart';

class VerifyAuthScreen extends StatelessWidget {
  const VerifyAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: true);
    return Scaffold(
      body: Center(
        child: FutureBuilder(
            future: authService.leerToken(),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData)
                //ignore: curly_braces_in_flow_control_structures
                return const Text(
                  'Espere...',
                  style: TextStyle(fontSize: 28),
                );
              // return Text('');

              if (snapshot.data == '') {
                Future.microtask(
                  () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, MyRoutes.rLogin, (route) => false);
                  },
                );
              } else {
                Future.microtask(
                  () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, MyRoutes.rHome, (route) => false);
                  },
                );
              }
              return Container();
            }),
      ),
    );
  }
}
