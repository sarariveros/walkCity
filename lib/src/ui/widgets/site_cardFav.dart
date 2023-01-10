import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:walkcity/src/models/favorito_model.dart';
import 'package:walkcity/src/models/site_model.dart';
import 'package:walkcity/src/preferences/preferences.dart';
import 'package:walkcity/src/providers/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/screens/index.dart';

class SiteCardFav extends StatefulWidget {
  final Site site;

  const SiteCardFav({
    super.key,
    required this.site,
  });

  @override
  State<SiteCardFav> createState() => _SiteCardFavState();
}

class _SiteCardFavState extends State<SiteCardFav> {
  @override
  Widget build(BuildContext context) {
    final sbFav = Provider.of<SBFavorite>(context);
    final favorito = sbFav.favoritos
        .where((element) => element.id_site == widget.site.id)
        .toList();
    int isVisited = favorito[0].estado!;
    return GestureDetector(
        onDoubleTap: () {
          sbFav.removeFavorite(Favorito.fromMap({
            'id_site': widget.site.id,
            'estado': 0,
            'usuario': Preferences.identificador
          }));
          // }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(6),
              padding: const EdgeInsets.all(4),
              height: 185,
              width: MediaQuery.of(context).size.width / 2 - 10,
              decoration: BoxDecoration(
                color: const Color.fromARGB(106, 144, 225, 239),
                border:
                    Border.all(color: const Color.fromARGB(111, 204, 201, 201)),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromARGB(118, 174, 180, 180),
                    blurRadius: 5.0,
                    spreadRadius: 2.0,
                    offset: Offset(0.0, 0.0),
                  )
                ],
              ),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    height: 125,
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      image: DecorationImage(
                        image: NetworkImage(widget.site.imagen!),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Stack(
                      alignment: AlignmentDirectional.topEnd,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(155, 200, 218, 213),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              width: 35,
                              height: 35,
                              child: SizedBox(
                                height: 35,
                                child: IconButton(
                                    onPressed: () {
                                      String msg =
                                          'Te invito a Visitar ${widget.site.nombre} en Ayacucho / Peru. Conoce mas atraves de WalkCity https://melodious-cat-451886.netlify.app/';
                                      Share.share(msg);
                                    },
                                    icon: const Icon(
                                      Icons.share,
                                      size: 20,
                                      color: Color.fromARGB(211, 0, 0, 0),
                                    )),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(155, 200, 218, 213),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              width: 35,
                              height: 35,
                              child: SizedBox(
                                height: 35,
                                child: IconButton(
                                    onPressed: () {
                                      sbFav.removeFavorite(Favorito.fromMap({
                                        'id_site': widget.site.id,
                                        'estado': 0,
                                        'usuario': Preferences.identificador
                                      }));
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 20,
                                      color: Color.fromARGB(211, 0, 0, 0),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                    child: Text(
                      widget.site.nombre!,
                      textAlign: TextAlign.center,
                      style: Styles.scNameStyle,
                      overflow: TextOverflow.ellipsis,
                      // softWrap: true,
                      //maxLines: 3,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        width: 75,
                        height: 30,
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
                                        PlacePage(site: widget.site)));
                          },
                        ),
                      ),
                      SizedBox(
                        width: 25,
                        height: 30,
                        child: IconButton(
                          icon: (isVisited == 1)
                              ? const Icon(
                                  Icons.check_box_outlined,
                                  size: 20,
                                  color: Color.fromARGB(211, 0, 0, 0),
                                )
                              : const Icon(
                                  Icons.check_box_outline_blank_sharp,
                                  size: 20,
                                  color: Color.fromARGB(211, 0, 0, 0),
                                ),
                          onPressed: () async {
                            if (favorito.isNotEmpty) {
                              setState(() {
                                isVisited = 1;
                              });

                              Future.delayed(const Duration(seconds: 10));
                              sbFav.updateFav(favorito[0]);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
