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
                // boxShadow: const [
                //   BoxShadow(
                //     color: Color.fromARGB(235, 143, 165, 161),
                //     blurRadius: 4.0,
                //     spreadRadius: 2.0,
                //     offset: Offset(0.0, 0.0),
                //   )
                // ],
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
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 30,
        actions: [
          IconButton(
            onPressed: () {
              wshowDialog(context, 'TIPS');
            },
            icon: Icon(Icons.sunny_snowing, color: Styles.firstColor),
            alignment: Alignment.centerRight,
          ),
        ],
      ),
      body: opcionesMenu.elementAt(_selectItem),
      bottomNavigationBar: CurvedNavigationBar(
        index: _selectItem,
        animationDuration: const Duration(milliseconds: 350),
        backgroundColor: Colors.white,
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
      // BottomNavigationBar(
      //   elevation: 2,
      //   iconSize: 20,
      //   backgroundColor: Colors.white,
      //   currentIndex: _selectItem,

      //   type: BottomNavigationBarType.fixed,
      //   //backgroundColor: Colors.black,
      //   onTap: (value) => setState(() {
      //     _selectItem = value;
      //   }),
      //   unselectedItemColor: Colors.grey,
      //   selectedItemColor: Styles.firstColor,
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Inicio',
      //     ),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.newspaper), label: 'Festividades'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.favorite), label: 'Favoritos'),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.people),
      //         // CircleAvatar(
      //         //   backgroundImage: NetworkImage(
      //         //       'https://cdn.pixabay.com/photo/2021/05/23/00/21/woman-6274879_960_720.png'),
      //         //   radius: 15,
      //         // ),
      //         label: 'Perfil'),
      //   ],
      //   // currentIndex: _selectedIndex,
    );
  }
}
