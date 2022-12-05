import 'package:flutter/material.dart';
import 'package:walkcity/src/styles/style.dart';

class SiteCard extends StatelessWidget {
  final String nombre;
  final String descripcion;

  const SiteCard({super.key, required this.nombre, required this.descripcion});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
            decoration: const BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.vertical(
                  top: Radius.circular(10), bottom: Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/11/27/20/28/cathedral-1066314_960_720.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  child: Text(
                    nombre,
                    textAlign: TextAlign.start,
                    style: Styles.sitecardTStyle,
                    overflow: TextOverflow.clip,
                  ),
                ),
                Text(
                  descripcion,
                  style: Styles.sitecardDStyle,
                  overflow: TextOverflow.ellipsis,
                ),
                OutlinedButton.icon(
                  style: ButtonStyle(
                      side: MaterialStateProperty.all(const BorderSide(
                          color: Colors.orange,
                          width: 1.0,
                          style: BorderStyle.solid))),
                  label: Text(
                    'Visitar',
                    style: Styles.sitecardBStyle,
                  ),
                  onPressed: () {},
                  icon: const Icon(
                    Icons.send,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
