import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/routes/routes.dart';
import 'package:walkcity/src/ui/screens/profileSettings.dart';
import '../../services/service_auth.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  dynamic dataUser = {};

  @override
  void initState() {
    super.initState();

    actualizarData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 20.0),
              width: double.infinity,
              height: 250,
              decoration: const BoxDecoration(
                color: Color.fromRGBO(228, 36, 36, .7),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: Colors.white,
                      image: DecorationImage(
                        image: NetworkImage(
                          dataUser["image"] == null
                              ? "https://cultura-sorda.org/wp-content/uploads/2015/02/Usuario-Vacio-300x300.png"
                              : 'https://kowzlncfrrqjcojxapmv.supabase.co/storage/v1/object/public/profile.images/data/user/0/com.example.walkcity/cache/${dataUser["image"]}',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.settings,
                          color: Color.fromRGBO(228, 36, 36, .7),
                          size: 30,
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const ProfileSettingPage()));
                        },
                      ),
                    ],
                  ),
                  Text(dataUser["email"] ?? ""),
                  Text(
                    dataUser["nombre"] ?? "",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: Color.fromRGBO(139, 140, 142, 1),
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.numbers,
                        size: 30,
                        color: Color.fromRGBO(180, 180, 190, 1),
                      ),
                      Text(
                          dataUser["edad"] == null
                              ? ""
                              : dataUser["edad"].toString(),
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w900,
                            color: Color.fromRGBO(180, 180, 190, 1),
                          ))
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 40),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Prosedencia: ",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(180, 180, 190, 1),
                            )),
                        Text(dataUser["origen"] ?? "",
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(180, 180, 190, 1),
                            ))
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                  MaterialButton(
                    height: 60,
                    minWidth: double.infinity,
                    color: const Color.fromRGBO(228, 36, 36, .7),
                    onPressed: () async {
                      FocusScope.of(context).unfocus();

                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      final String? errorMessage =
                          await authService.cerrarSesion();

                      if (errorMessage == null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(
                            context, MyRoutes.rLogin);
                      }
                    },
                    child: const Text(
                      "Cerrar sesion",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void actualizarData() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final data = await authService.traerDataUser();
    setState(() {
      dataUser = data;
    });
  }
}
