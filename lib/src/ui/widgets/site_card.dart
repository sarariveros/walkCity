import 'package:flutter/material.dart';
import 'package:walkcity/src/models/site_model.dart';
import 'package:walkcity/src/providers/index.dart';
import 'package:walkcity/src/services/index.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/screens/index.dart';
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
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      height: 350,
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
                image: NetworkImage(site.image!),
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
                  height: 40,
                  child: Text(
                    site.titulo!,
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
                        onPressed: () {
                          Navigator.push(context,
                          MaterialPageRoute(builder: (context) => PlacePage()));
                        },
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
                                titulo: site.titulo,
                                descripcion: site.descripcion,
                                image: site.image,
                                categoria: 'favoritos',
                                lat: site.lat,
                                lon: site.lon);
                            NotificationServices.showSnackbar(
                                'Añadido a Favoritos', 1);
                          } else if (icon == Icons.remove_circle_outline) {
                            favorites.delete(site.id);
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
