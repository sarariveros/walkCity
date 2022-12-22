import 'package:flutter/material.dart';
import 'package:walkcity/src/models/site_model.dart';
import 'package:walkcity/src/providers/index.dart';
import 'package:walkcity/src/services/index.dart';
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
    final favorites = Provider.of<SiteProvider>(context);
    return Container(
      margin: const EdgeInsets.only(right: 15, top: 5),
      height: 150,
      width: (MediaQuery.of(context).size.width / 2) - 15,
      decoration: BoxDecoration(
        color: Styles.firstColor,
        borderRadius: const BorderRadius.vertical(
            top: Radius.circular(10), bottom: Radius.circular(10)),
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            // width: (MediaQuery.of(context).size.width / 2) - 15,
            decoration: BoxDecoration(
              color: Styles.firstColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(10),
                // bottom: Radius.circular(10)
              ),
              image: DecorationImage(
                image: NetworkImage(site.imagen!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 45,
                  child: Text(
                    site.nombre!,
                    textAlign: TextAlign.left,
                    style: Styles.sitecardTStyle,
                    overflow: TextOverflow.clip,
                  ),
                ),
              ),
              Container(
                height: 45,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(230, 233, 78, 78),
                  //Styles.firstColor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(10)),
                ),
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(230, 233, 78, 78),
                          minimumSize: const Size(20, 20),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(7)),
                      child: Icon(
                        Icons.send,
                        size: 22,
                        color: Styles.firstColor,
                      ),
                      onPressed: () {
                        print('desde card site: ' + site.latitud.toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlacePage(site: site)));
                      },
                    ),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(230, 233, 78, 78),
                          minimumSize: const Size(20, 20),
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(7)),
                      child: Icon(
                        icon,
                        size: 22,
                        color: Styles.firstColor,
                      ),
                      onPressed: () {
                        if (icon == Icons.favorite) {
                          favorites.addSite(
                              idSite: site.id,
                              nombre: site.nombre!,
                              imagen: site.imagen!,
                              idCategoria: site.id_categoria!,
                              lat: site.latitud!,
                              lon: site.longitud!);

                          NotificationServices.showSnackbar(
                              'Añadido a Favoritos', 1);
                        } else if (icon == Icons.delete) {
                          favorites.delete(site);
                          NotificationServices.showSnackbar(
                              'Quitado de Favoritos', 2);
                        }
                      },
                    ),
                    // IconButton()
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
