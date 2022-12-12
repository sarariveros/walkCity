import 'package:flutter/material.dart';

import '../widgets/index.dart';

class ComentsPage extends StatefulWidget {
  const ComentsPage({super.key});

  @override
  State<ComentsPage> createState() => _ComentsPageState();
}

class _ComentsPageState extends State<ComentsPage> {
  List<dynamic> coments = [
    {
      "img":
          "https://img.freepik.com/foto-gratis/retrato-hombre-blanco-aislado_53876-40306.jpg?w=2000",
      "name": "Carlos Cabrera",
      "date": "10 dic 10:11pm",
      "comment": "Esta bien chito esta vaina"
    },
    {
      "img":
          "https://estaticos.muyinteresante.es/uploads/images/article/55365cde3787b2187a1f0fbc/impresion-cara.jpg",
      "name": "Goel Gonzalez",
      "date": "10 dic 10:11pm",
      "comment": "Esta bien chito esta vaina"
    },
    {
      "img":
          "https://www.okchicas.com/wp-content/uploads/2016/01/Qu%C3%A9-dice-tu-rostro-de-ti-3.jpg",
      "name": "Franchesca Maldini",
      "date": "10 dic 10:11pm",
      "comment": "Esta bien chito esta vaina"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 70, 10, 0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Comentarios (${coments.length})',
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const ShowSheet()
              ],
            ),
            ListView.builder(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: coments.length,
              itemBuilder: (BuildContext context, int i) {
                return comment(data: coments[i]);
              },
            )
          ],
        ),
      ),
    );
  }
}
