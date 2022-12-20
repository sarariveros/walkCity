import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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
    InicioScreen(),
    FestividaddesScreen(),
    FavoritosScreen(),
    PerfilScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    void wshowDialog(BuildContext context, String title) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              title,
              textAlign: TextAlign.center,
            ),
            content: const WeatherWidget(),
            actions: <Widget>[
              TextButton(
                child: const Text('Salir'),
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
        toolbarHeight: 35,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite, color: Styles.secondColor),
            alignment: Alignment.centerRight,
          ),
          PopupMenuButton<String>(
            elevation: 40,
            color: const Color.fromARGB(174, 168, 154, 22),
            onSelected: handleClick,
            itemBuilder: (BuildContext context) {
              return {'Tips', 'Cerrar Sesion'}.map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: SizedBox(
                    width: 40,
                    height: 25,
                    child: Text(
                      choice,
                      style: const TextStyle(fontSize: 13),
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
