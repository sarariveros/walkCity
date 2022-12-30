import 'package:flutter/material.dart';
import 'package:walkcity/src/models/favorito_model.dart';
import 'package:walkcity/src/models/site_model.dart';
import 'package:walkcity/src/preferences/preferences.dart';
import 'package:walkcity/src/providers/favorite_provider.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/screens/index.dart';

class SiteCardFav extends StatelessWidget {
  final IconData icon;
  final Site site;

  const SiteCardFav({
    super.key,
    required this.icon,
    required this.site,
  });

  @override
  Widget build(BuildContext context) {
    final sbFav = Provider.of<SBFavorite>(context);
    final favorito =
        sbFav.favoritos.where((element) => element.id_site == site.id).toList();
    return GestureDetector(
        onDoubleTap: (() => sbFav.updateFav(favorito[0])),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.all(4),
              height: 230,
              width: MediaQuery.of(context).size.width / 2 - 10,
              decoration: BoxDecoration(
                color: Colors.white,
                border:
                    Border.all(color: const Color.fromARGB(185, 204, 201, 201)),
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffDDDDDD),
                    blurRadius: 6.0,
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
                    width: MediaQuery.of(context).size.width / 2 - 10,
                    decoration: BoxDecoration(
                      // border: Border.all(
                      //     color: const Color.fromARGB(207, 182, 177, 177
                      //     )),
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
                            color: Color.fromARGB(123, 79, 80, 79),
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
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              site.nombre!,
                              textAlign: TextAlign.left,
                              style: Styles.sitecardTStyle,
                              overflow: TextOverflow.ellipsis,
                              // softWrap: true,
                              //maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ));

    // return Container(
    //   margin: const EdgeInsets.only(right: 10, top: 5),
    //   height: 180,
    //   width: (MediaQuery.of(context).size.width / 2) - 15,
    //   decoration: BoxDecoration(
    //     color: Styles.firstColor,
    //     borderRadius: const BorderRadius.vertical(
    //         top: Radius.circular(10), bottom: Radius.circular(10)),
    //   ),
    //   child: Column(
    //     children: [
    //       Container(
    //         height: 120,
    //         decoration: BoxDecoration(
    //           color: Styles.firstColor,
    //           borderRadius: const BorderRadius.vertical(
    //             top: Radius.circular(10),
    //             // bottom: Radius.circular(10)
    //           ),
    //           image: DecorationImage(
    //             image: NetworkImage(site.imagen!),
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //       ),
    //       Column(
    //         crossAxisAlignment: CrossAxisAlignment.start,
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.all(8.0),
    //             child: SizedBox(
    //               height: 45,
    //               child: Text(
    //                 site.nombre!,
    //                 textAlign: TextAlign.left,
    //                 style: Styles.sitecardTStyle,
    //                 // overflow: TextOverflow.clip,
    //               ),
    //             ),
    //           ),
    //           Stack(alignment: AlignmentDirectional.bottomCenter, children: [
    //             Container(
    //               height: 45,
    //               decoration: const BoxDecoration(
    //                 color: Color.fromARGB(230, 233, 78, 78),
    //                 //Styles.firstColor,
    //                 borderRadius:
    //                     BorderRadius.vertical(bottom: Radius.circular(10)),
    //               ),
    //               width: double.infinity,
    //               child: Row(
    //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                 crossAxisAlignment: CrossAxisAlignment.center,
    //                 children: [
    //                   ElevatedButton(
    //                     style: ElevatedButton.styleFrom(
    //                         backgroundColor:
    //                             const Color.fromARGB(230, 233, 78, 78),
    //                         minimumSize: const Size(20, 20),
    //                         shape: const CircleBorder(),
    //                         padding: const EdgeInsets.all(7)),
    //                     child: Icon(
    //                       Icons.message,
    //                       size: 22,
    //                       color: Styles.firstColor,
    //                     ),
    //                     onPressed: () {
    //                       Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                               builder: (context) => ComentsPage(
    //                                     idSite: site,
    //                                   )));
    //                     },
    //                   ),
    //                   ElevatedButton(
    //                     style: ElevatedButton.styleFrom(
    //                         backgroundColor:
    //                             const Color.fromARGB(230, 233, 78, 78),
    //                         minimumSize: const Size(20, 20),
    //                         shape: const CircleBorder(),
    //                         padding: const EdgeInsets.all(7)),
    //                     child: Icon(
    //                       Icons.send,
    //                       size: 22,
    //                       color: Styles.firstColor,
    //                     ),
    //                     onPressed: () {
    //                       Navigator.push(
    //                           context,
    //                           MaterialPageRoute(
    //                               builder: (context) => PlacePage(site: site)));
    //                     },
    //                   ),

    //                   ElevatedButton(
    //                     style: ElevatedButton.styleFrom(
    //                         backgroundColor:
    //                             const Color.fromARGB(230, 233, 78, 78),
    //                         minimumSize: const Size(20, 20),
    //                         shape: const CircleBorder(),
    //                         padding: const EdgeInsets.all(7)),
    //                     child: Icon(
    //                       icon,
    //                       size: 22,
    //                       color: Styles.firstColor,
    //                     ),
    //                     onPressed: () {
    //                       if (icon == Icons.favorite) {
    //                         sbFav.addFavorite(Favorito.fromMap({
    //                           'id_site': site.id,
    //                           'estado': 0,
    //                           'usuario': Preferences.identificador
    //                         }));
    //                       } else if (icon == Icons.delete) {
    //                         sbFav.removeFavorite(Favorito.fromMap({
    //                           'id_site': site.id,
    //                           'estado': 0,
    //                           'usuario': Preferences.identificador
    //                         }));
    //                       }
    //                     },
    //                   ),
    //                   // IconButton()
    //                 ],
    //               ),
    //             ),
    //           ]),
    //         ],
    //       ),
    //     ],
    //   ),
    //);
  }
}
