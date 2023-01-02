import 'package:flutter/material.dart';
import 'package:walkcity/src/models/favorito_model.dart';
import 'package:walkcity/src/models/site_model.dart';
import 'package:walkcity/src/preferences/preferences.dart';
import 'package:walkcity/src/providers/favorite_provider.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/ui/screens/index.dart';

class SiteCard extends StatelessWidget {
  final IconData icon;
  final Site site;

  const SiteCard({
    super.key,
    required this.icon,
    required this.site,
  });

  @override
  Widget build(BuildContext context) {
    final sbFav = Provider.of<SBFavorite>(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          padding: const EdgeInsets.all(4),
          height: 210,
          decoration: BoxDecoration(
            color: Styles.firstColor.withOpacity(0.5),
            border: Border.all(color: Color.fromARGB(111, 204, 201, 201)),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(216, 174, 180, 180),
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
                width: MediaQuery.of(context).size.width - 30,
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
                        color: Color.fromARGB(155, 79, 80, 79),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      width: 40,
                      height: 145,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          IconButton(
                            icon: const Icon(
                              Icons.chat_outlined,
                              size: 22,
                              color: Colors.white,
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
                            icon: const Icon(
                              Icons.send,
                              size: 22,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PlacePage(site: site)));
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              icon,
                              size: 22,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              if (icon == Icons.favorite) {
                                sbFav.addFavorite(Favorito.fromMap({
                                  'id_site': site.id,
                                  'estado': 0,
                                  'usuario': Preferences.identificador
                                }));
                              } else if (icon == Icons.delete) {
                                sbFav.removeFavorite(Favorito.fromMap({
                                  'id_site': site.id,
                                  'estado': 0,
                                  'usuario': Preferences.identificador
                                }));
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Center(
                child: SizedBox(
                  height: 30,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                          width: 260,
                          child: Text(
                            site.nombre!,
                            textAlign: TextAlign.left,
                            style: Styles.sitecardTStyle,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                        TextButton(
                            onPressed: () {},
                            child: const Text(
                              '100k',
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
