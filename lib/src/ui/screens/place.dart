import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/models/index.dart';
import 'package:walkcity/src/preferences/preferences.dart';
import 'package:walkcity/src/providers/favorite_provider.dart';
import 'package:walkcity/src/providers/map_provider.dart';
import 'package:walkcity/src/resources/category_icons.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/screens/index.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class PlacePage extends StatelessWidget {
  final Site site;

  const PlacePage({super.key, required this.site});

  @override
  Widget build(BuildContext context) {
    final mapProvider = Provider.of<MapProvider>(context);
    final sbFav = Provider.of<SBFavorite>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    sbFav.addFavorite(Favorito.fromMap({
                      'id_site': site.id,
                      'estado': 0,
                      'usuario': Preferences.identificador
                    }));
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: Styles.thirdColor,
                  ))
            ],
            elevation: 0,
            pinned: true,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(40),
              child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Color.fromARGB(100, 255, 255, 255),
                        Color.fromARGB(150, 255, 255, 255),
                        Color.fromARGB(200, 255, 255, 255),
                        Color.fromARGB(220, 255, 255, 255),
                        Color.fromARGB(255, 255, 255, 255),
                      ],
                    ),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30)),
                    color: Color.fromARGB(255, 255, 255, 255),
                  ),
                  width: double.maxFinite,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        site.nombre!,
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Styles.textColor),
                      ),
                      CategoryIcon.iconCategory(site.id_categoria!),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        child: Text(
                          "Descripcion",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Styles.firstColor),
                        ),
                      )
                    ],
                  )),
            ),
            expandedHeight: MediaQuery.of(context).size.height * 0.5,
            collapsedHeight: 100,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                site.imagen!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                    color: Colors.white,
                    margin:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    child: Text(
                      site.descripcion!,
                      style: const TextStyle(fontSize: 16),
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: YoutubePlayer(
                    controller: YoutubePlayerController(
                      initialVideoId: site.linkVideo!,
                      flags: const YoutubePlayerFlags(
                        autoPlay: false,
                        mute: false,
                      ),
                    ),
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Styles.secondColor,
                    progressColors: const ProgressBarColors(
                      playedColor: Color.fromARGB(255, 232, 60, 48),
                      handleColor: Color.fromARGB(255, 232, 60, 48),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Styles.firstColor,
                              maximumSize: Size.fromWidth(
                                  MediaQuery.of(context).size.height * 0.25)),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ComentsPage(
                                          idSite: site,
                                        )));
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: const [
                                Icon(
                                  Icons.chat,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                // SizedBox(
                                //   width: 10,
                                // ),
                                Text(
                                  "Comentarios",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          )),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Styles.firstColor,
                              maximumSize: Size.fromWidth(
                                  MediaQuery.of(context).size.height * 0.25)),
                          onPressed: () {
                            mapProvider.goMap(site.linkMap!);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: const [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                // SizedBox(
                                //   width: 10,
                                // ),
                                Text(
                                  "Ir al mapa",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
