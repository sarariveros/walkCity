import 'package:flutter/material.dart';
import 'package:path/path.dart';
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
            backgroundColor: Color.fromARGB(197, 134, 231, 186),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.tips_and_updates,
                  color: Colors.amberAccent,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            // Icon(Icons.close),

            content: const WeatherWidget(),
            actions: <Widget>[
              TextButton(
                child: const Text(
                  'Salir',
                  style: TextStyle(color: Colors.black),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }

    void handleClick(String value) {
      switch (value) {
        case 'Tips':
          wshowDialog(context, 'Tips');
          break;
        case 'Cerrar Sesion':
          break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        toolbarHeight: 30,
        actions: [
          // IconButton(
          //   onPressed: () {},
          //   icon: Icon(Icons.favorite, color: Styles.secondColor),
          //   alignment: Alignment.centerRight,
          // ),
          PopupMenuButton<String>(
            //splashRadius: 2,
            elevation: 20,
            color: Color.fromARGB(218, 235, 232, 212),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Tips', 'Cerrar Sesion'}.map((String choice) {
                return PopupMenuItem<String>(
                  height: 30,
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  value: choice,
                  child: SizedBox(
                    width: 80,
                    height: 15,
                    child: Text(
                      choice,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ),
                );
              }).toList();
            },
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
        selectedItemColor: Colors.amber[800],
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
