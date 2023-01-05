import 'package:flutter/material.dart';

class Page3 extends StatelessWidget {
  const Page3({super.key});

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
            color: Colors.deepPurple[400],
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: const [
                  Text('1'),
                  Text('Navega atraves del listado de lugares por visitar'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
