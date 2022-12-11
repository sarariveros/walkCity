import 'package:flutter/material.dart';
import 'package:walkcity/src/models/index.dart';
import 'package:walkcity/src/providers/index.dart';
import 'package:walkcity/src/providers/weather_provider.dart';
import 'package:walkcity/src/resources/sites_repository.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/widgets/index.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final showWeather = Provider.of<SWeatherProvider>(context, listen: false);

    return Scaffold(
      //key: messengerKey,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '¿Listo?',
                    style: Styles.textStyleB,
                  ),
                  const Text('Ayacucho, Peru'),
                  // IconButton(
                  //   tooltip: 'Clima',
                  //   onPressed: () {
                  //     //codigo para ocultar widget
                  //   },
                  //   icon: const Icon(
                  //     Icons.sunny,
                  //   ),
                  //   color: Colors.orange,
                  // ),
                  Switch(
                      value: showWeather.estado,
                      onChanged: ((value) {
                        showWeather.changeVisibility();
                        value = showWeather.estado;
                      })),
                ],
              ),
              const WeatherWidget(),
              Text(
                'Sitios',
                style: Styles.textStyle,
              ),
              const ListAllSites(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        //backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.amber[800],
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'News'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              // CircleAvatar(
              //   backgroundImage: NetworkImage(
              //       'https://cdn.pixabay.com/photo/2021/05/23/00/21/woman-6274879_960_720.png'),
              //   radius: 15,
              // ),
              label: 'Profile'),
        ],
        // currentIndex: _selectedIndex,
      ),
    );
  }
}

class ListAllSites extends StatelessWidget {
  const ListAllSites({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Site> showFavorites() {
      final favorites = Provider.of<SiteProvider>(context, listen: true);
      favorites.queryAll();
      return favorites.sites;
    }

    return Column(
      children: [
        ListSites(
          categoria: 'Iglesias',
          sites: SiteRepository.iglesias,
        ),
        ListSites(
          categoria: 'Parques',
          sites: SiteRepository.parques,
        ),
        ListSites(
          categoria: 'Museos',
          sites: SiteRepository.museos,
        ),
        ListSites(
            categoria: 'Favoritos', sites: showFavorites() //favorites.sites,
            ),
      ],
    );
  }
}
