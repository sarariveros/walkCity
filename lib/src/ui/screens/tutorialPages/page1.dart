import 'package:flutter/material.dart';
import 'package:walkcity/src/styles/style.dart';

class Page1 extends StatelessWidget {
  final int numero;
  final String msg;

  const Page1({super.key, required this.numero, required this.msg});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            height: 440,
            color: Colors.blueGrey[400],
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    numero.toString(),
                    style: Styles.tutorialNumber,
                  ),
                  Text(
                    msg,
                    textAlign: TextAlign.center,
                    style: Styles.tutorialText,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
