import 'package:flutter/material.dart';
import 'package:walkcity/src/models/index.dart';
import 'package:walkcity/src/providers/weather_provider.dart';
import 'package:walkcity/src/services/supabase_site.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/widgets/index.dart';
import 'package:provider/provider.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  @override
  Widget build(BuildContext context) {
    final show = Provider.of<SWeatherProvider>(context, listen: true);
    final SBSite sbSite = SBSite();
    // List<Site> sites = [];
    // List<Category> categories = [];

    // Future<void> fillData() async {
    //   sites = await sbSite.getAllSites();
    //   categories = await sbSite.getcategorias();
    // }

    // fillData();

    return SingleChildScrollView(
      child: Column(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Styles.secondColor,
                            radius: 18,
                            child: Image.asset(
                              'assets/escudo.png',
                              height: 30,
                              width: 30,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Ayacucho, Peru',
                            style: Styles.title,
                          ),
                        ],
                      ),
                      IconButton(
                        tooltip: 'Clima',
                        onPressed: () {
                          show.changeVisibility();
                          //codigo para ocultar widget
                        },
                        icon: (!show.showWeather)
                            ? const Icon(Icons.sunny)
                            : const Icon(Icons.self_improvement_sharp),
                        color: Colors.orange,
                      ),
                    ],
                  ),
                  Text(
                    'Explora nuestra hermosa ciudad',
                    style: Styles.textStyle,
                  ),
                  Visibility(
                      visible: show.showWeather, child: const WeatherWidget()),
                  // const ListAllSites(),

                  FutureBuilder(
                    future: sbSite.getcategorias(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List datos = snapshot.data!;
                        return SizedBox(
                          height: 250,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: false,
                            itemCount: datos.length,
                            itemBuilder: (context, index) {
                              return FutureBuilder(
                                future: sbSite.getSiteByCat(datos[index].id),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    List<Site> sites = [];
                                    List data = snapshot.data!;
                                    for (var element in data) {
                                      Site site = Site.fromMap(element);
                                      sites.add(site);
                                    }
                                    return ListSites(
                                      categoria: datos[index].nombre,
                                      sites: sites,
                                    );
                                  }
                                  return Text('data');
                                },
                              );
                            },
                          ),
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          color: Styles.firstColor,
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          ),
        ],
        //bottomNavigationBar: const MenuWidget(),
      ),
    );
  }
}

// class ListAllSites extends StatelessWidget {
//   const ListAllSites({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     List<Site> showFavorites() {
//       final favorites = Provider.of<SiteProvider>(context, listen: true);
//       favorites.queryAll();
//       return favorites.sites;
//     }

//     return Column(
//       children: [
//         ListSites(
//           categoria: 'Iglesias',
//           sites: SiteRepository.iglesias,
//         ),
//         ListSites(
//           categoria: 'Parques',
//           sites: SiteRepository.parques,
//         ),
//         ListSites(
//           categoria: 'Museos',
//           sites: SiteRepository.museos,
//         ),
//         ListSites(
//             categoria: 'Favoritos', sites: showFavorites() //favorites.sites,
//             ),
//       ],
//     );
//   }
// }
