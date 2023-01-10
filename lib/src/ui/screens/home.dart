import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/screens/index.dart';
import 'package:walkcity/src/ui/widgets/index.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectItem = 0;
  List<Widget> opcionesMenu = [
    const InicioScreen(),
    const FestividaddesScreen(),
    const FavoritosScreen(),
    const PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    void wshowDialog(BuildContext context, String title) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            //const Color.fromARGB(197, 134, 231, 186),
            title: Container(
              decoration: BoxDecoration(
                color: Styles.firstColor,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(15),
                ),
              ),
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.tips_and_updates,
                    color: Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            // Icon(Icons.close),

            content: const WeatherWidget(),
            actions: <Widget>[
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text(
                    'ENTENDIDO',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              )
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      // Color.fromARGB(255, 14, 90, 84),
      // Styles.firstColor,
      // Colors.white,
      //  const Color.fromARGB(221, 206, 255, 251),
      appBar: AppBar(
        // backgroundColor: Color.fromARGB(221, 206, 255, 251),
        automaticallyImplyLeading: false,
        toolbarHeight: 30,
        actions: [
          IconButton(
            onPressed: () {
              wshowDialog(context, 'TIPS');
            },
            icon: Icon(Icons.sunny_snowing, color: Styles.fouthColor),
            alignment: Alignment.centerRight,
          ),
        ],
      ),
      body: opcionesMenu.elementAt(_selectItem),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectItem,
        animationDuration: const Duration(milliseconds: 350),
        backgroundColor: Colors.white,
        // const Color.fromARGB(221, 178, 223, 219),
        buttonBackgroundColor: Styles.firstColor,
        color: Styles.firstColor,
        height: 48,
        items: const [
          Icon(
            Icons.home,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.newspaper,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.favorite,
            size: 30,
            color: Colors.white,
          ),
          Icon(
            Icons.people,
            size: 30,
            color: Colors.white,
          ),
        ],
        onTap: (value) => setState(() {
          _selectItem = value;
        }),
      ),
    );
  }
}
