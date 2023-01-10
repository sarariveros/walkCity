import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:walkcity/src/routes/routes.dart';
import 'package:walkcity/src/styles/style.dart';
import 'tutorialPages/page1.dart';
import 'tutorialPages/page2.dart';
import 'tutorialPages/page3.dart';
import 'tutorialPages/page4.dart';

class TutorialPage extends StatelessWidget {
  const TutorialPage({super.key});

  @override
  Widget build(BuildContext context) {
    final msgList = [
      'Navega atraves del listado de lugares por visitar',
      "Revisar los detalles, agrega a tu lista de favoritos. \nRevisa y registra comentarios acerca de este lugar",
      'Da una mirada por el calendario de festividades. Puede haber algo muy interesante',
      'Si ya visitaste lugares de tu lista de favoritos. Marcalos como Visitados'
    ];
    final _controller = PageController(keepPage: false);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // page view
            Expanded(
              child: SizedBox(
                height: 450,
                child: PageView(
                  controller: _controller,
                  children: [
                    Page1(numero: 1, msg: msgList[0]),
                    Page1(numero: 2, msg: msgList[1]),
                    Page1(numero: 3, msg: msgList[2]),
                    Page1(numero: 4, msg: msgList[3]),
                  ],
                ),
              ),
            ),

            // dot indicators
            SmoothPageIndicator(
              controller: _controller,
              count: 4,
              effect: JumpingDotEffect(
                activeDotColor: Colors.lightBlue,
                dotColor: Colors.deepPurple.shade100,
                dotHeight: 15,
                dotWidth: 15,
                spacing: 16,
                //verticalOffset: 50,
                jumpScale: 3,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              height: 38,
              child: MaterialButton(
                color: Styles.firstColor,
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, MyRoutes.rHome),
                child: const Text('Omitir'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
