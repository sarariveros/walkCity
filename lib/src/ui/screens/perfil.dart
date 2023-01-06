import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/resources/countries.dart';
import 'package:walkcity/src/routes/routes.dart';
import 'package:walkcity/src/ui/screens/profileSettings.dart';
import '../../services/service_auth.dart';
import 'package:walkcity/src/styles/style.dart';

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
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: -10,
            width: 200,
            height: 200,
            child: Image.asset("assets/shape_01.png"),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  width: double.infinity,
                  height: 270,
                  decoration: BoxDecoration(
                      color: Styles.firstColor,
                      backgroundBlendMode: BlendMode.multiply),
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
                            image: NetworkImage(dataUser["image"] == null ||
                                    dataUser["image"] == ""
                                ? "https://cultura-sorda.org/wp-content/uploads/2015/02/Usuario-Vacio-300x300.png"
                                : 'https://kowzlncfrrqjcojxapmv.supabase.co/storage/v1/object/public/profile.images/data/user/0/com.example.walkcity/cache/${dataUser["image"]}'),
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dataUser["nombre"] ?? "Cargando...",
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w900,
                              color: Color.fromRGBO(139, 140, 142, 1),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.edit,
                              color: Styles.firstColor,
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
                      Text(
                        dataUser["edad"] == null
                            ? ""
                            : '${dataUser["edad"].toString()} años',
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w900,
                          color: Color.fromRGBO(180, 180, 190, 1),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                dataUser["origen"] == null
                                    ? ""
                                    : selectEmoji(dataUser["origen"]),
                                style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromRGBO(180, 180, 190, 1),
                                )),
                          ],
                        ),
                      ),
                      MaterialButton(
                        height: 60,
                        minWidth: double.infinity,
                        color: Styles.firstColor,
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
        ],
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

  selectEmoji(String country) {
    final indexCountry =
        listCountries.indexWhere((e) => e["name"].trim() == country.trim());

    if (indexCountry >= 0) {
      return listCountries[indexCountry]["emoji"];
    }
    return country;
  }
}
