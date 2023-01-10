import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:walkcity/src/models/favorito_model.dart';
import 'package:walkcity/src/models/site_model.dart';
import 'package:walkcity/src/preferences/preferences.dart';
import 'package:walkcity/src/providers/favorite_provider.dart';
// import 'package:walkcity/src/resources/category_icons.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/ui/screens/index.dart';

class SiteCard extends StatelessWidget {
  // final IconData icon;
  final Site site;

  const SiteCard({
    super.key,
    // required this.icon,
    required this.site,
  });

  @override
  Widget build(BuildContext context) {
    final sbFav = Provider.of<SBFavorite>(context);
    return GestureDetector(
      onDoubleTap: () {
        sbFav.addFavorite(Favorito.fromMap({
          'id_site': site.id,
          'estado': 0,
          'usuario': Preferences.identificador
        }));
      },
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(5),
            padding: const EdgeInsets.only(top: 4, right: 4, left: 4),
            height: 215,
            width: MediaQuery.of(context).size.width - 25,
            decoration: BoxDecoration(
              color: const Color.fromARGB(106, 144, 225, 239),
              border: Border.all(color: Styles.secondColor, width: 1),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromARGB(95, 227, 252, 252),
                  blurRadius: 5.0,
                  spreadRadius: 2.0,
                  offset: Offset(0.0, 0.0),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  height: 170,
                  width: MediaQuery.of(context).size.width - 10,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    image: DecorationImage(
                      image: NetworkImage(site.imagen!),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(155, 200, 218, 213),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        width: 40,
                        height: 145,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.favorite_border,
                                size: 22,
                                color: Color.fromARGB(211, 0, 0, 0),
                                // Color.fromARGB(255, 28, 61, 119),
                              ),
                              onPressed: () {
                                sbFav.addFavorite(Favorito.fromMap({
                                  'id_site': site.id,
                                  'estado': 0,
                                  'usuario': Preferences.identificador
                                }));
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.chat_outlined,
                                size: 22,
                                color: Color.fromARGB(211, 0, 0, 0),
                                //  Color.fromARGB(255, 28, 61, 119),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ComentsPage(
                                              idSite: site,
                                            )));
                              },
                            ),
                            IconButton(
                                onPressed: () {
                                  String msg =
                                      'Te invito a Visitar ${site.nombre} en Ayacucho / Peru. Conoce mas atraves de WalkCity https://melodious-cat-451886.netlify.app/';
                                  Share.share(msg);
                                },
                                icon: const Icon(
                                  Icons.share,
                                  color: Color.fromARGB(211, 0, 0, 0),
                                ))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: SizedBox(
                      height: 35,
                      width: MediaQuery.of(context).size.width,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width - 115,
                            child: Text(
                              site.nombre!,
                              textAlign: TextAlign.left,
                              style: Styles.scNameStyle,
                              overflow: TextOverflow.clip,
                            ),
                          ),

                          SizedBox(
                            width: 75,
                            child: TextButton(
                              child: Text(
                                'VER MAS',
                                style: Styles.scVerStyle,
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            PlacePage(site: site)));
                              },
                            ),
                            // CategoryIcon.iconCategory(site.id_categoria!)
                          )
                          // '100k',
                          // style: TextStyle(
                          //     fontSize: 12, fontWeight: FontWeight.bold
                          //),
                          // )
                        ],
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
