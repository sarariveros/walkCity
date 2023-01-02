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
            backgroundColor: Styles.secondColor,
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
                  child: Text(
                    'ENTENDIDO',
                    style: TextStyle(color: Styles.thirdColor),
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

    // void handleClick(String value) {
    //   switch (value) {
    //     case 'Tips':
    //       wshowDialog(context, 'Tips');
    //       break;
    //     case 'Cerrar Sesion':
    //       break;
    //   }
    // }

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectItem,
        type: BottomNavigationBarType.fixed,
        //backgroundColor: Colors.black,
        onTap: (value) => setState(() {
          _selectItem = value;
        }),
        unselectedItemColor: Colors.grey,
        selectedItemColor: Styles.firstColor,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.newspaper), label: 'Festividades'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favoritos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              // CircleAvatar(
              //   backgroundImage: NetworkImage(
              //       'https://cdn.pixabay.com/photo/2021/05/23/00/21/woman-6274879_960_720.png'),
              //   radius: 15,
              // ),
              label: 'Perfil'),
        ],
        // currentIndex: _selectedIndex,
      ),
    );
  }
}
