import 'package:flutter/material.dart';
import 'package:walkcity/src/models/site_model.dart';
import 'package:walkcity/src/providers/index.dart';
import 'package:walkcity/src/services/index.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:provider/provider.dart';

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
    final favorites = Provider.of<SiteProvider>(context, listen: false);
    return Container(
      margin: const EdgeInsets.only(right: 15, top: 5),
      height: 250,
      width: 150,
      decoration: const BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(10), bottom: Radius.circular(10)),
      ),
      child: Column(
        children: [
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(10), bottom: Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(site.imagen!),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                  child: Text(
                    site.nombre!,
                    textAlign: TextAlign.left,
                    style: Styles.sitecardTStyle,
                    overflow: TextOverflow.clip,
                  ),
                ),

                // Text(
                //   site.descripcion!,
                //   style: Styles.sitecardDStyle,
                //   overflow: TextOverflow.ellipsis,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ButtonTheme(
                      minWidth: 80.0,
                      height: 100.0,
                      child: OutlinedButton.icon(
                        style: ButtonStyle(
                            //  maximumSize: MaterialStateProperty,
                            side: MaterialStateProperty.all(const BorderSide(
                                color: Colors.orange,
                                width: 1.0,
                                style: BorderStyle.solid))),
                        label: Text(
                          'Ir',
                          style: Styles.sitecardBStyle,
                        ),
                        onPressed: () {},
                        icon: Icon(
                          Icons.send,
                          color: Styles.secondColor,
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          if (icon == Icons.favorite_border) {
                            favorites.addSite(
                                nombre: site.nombre!,
                                imagen: site.imagen!,
                                categoria: '0',
                                lat: site.lat!,
                                lon: site.lon!);
                            NotificationServices.showSnackbar(
                                'Añadido a Favoritos', 1);
                          } else if (icon == Icons.delete) {
                            favorites.delete(site);
                            NotificationServices.showSnackbar(
                                'Quitado de Favoritos', 2);
                          }
                        },
                        icon: Icon(
                          // Icons.favorite_border,
                          icon!,
                          color: Styles.secondColor,
                        ))
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
