
import 'package:flutter/material.dart';
import 'package:walkcity/src/providers/index.dart';
import 'package:walkcity/src/styles/style.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final weatherProvider = WeaterApiProvider();
    int indice = 0;
    final List<Map<String, dynamic>> estadosClima = [
      {
        'estado': 'frio',
        'color': const Color.fromARGB(123, 192, 154, 29),
        'recomendacion':
            'Se recomienda llevar ropa de abrigo y proteccion en caso de lluvia',
        'imagenes': [
          Image.asset('assets/frio1.png'),
          Image.asset('assets/frio2.png'),
          Image.asset('assets/frio3.png')
        ]
      },
      {
        'estado': 'templado',
        'color': const Color.fromARGB(122, 29, 142, 207),
        'recomendacion':
            'Se recomienda el uso de sombreros y ropa comoda y ligera. Asegurate de llevar contenedores de agua contigo',
        'imagenes': [
          Image.asset('assets/templado1.png'),
          Image.asset('assets/templado2.png'),
          Image.asset('assets/templado3.png')
        ]
      },
      {
        'estado': 'calido',
        'color': const Color.fromARGB(121, 106, 228, 50),
        'recomendacion':
            'Se recomienda el uso de protector solar ademas del uso de sombreros y gorros. Muy aconsejable el uso de prendas que cubran las extremidades ',
        'imagenes': [
          Image.asset('assets/calido1.png'),
          Image.asset('assets/calido2.png'),
          Image.asset('assets/calido3.png')
        ]
      },
    ];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Pronostico del Clima'),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FutureBuilder(
                        future: weatherProvider.getweather(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final double temperatura =
                                (snapshot.data!['temp_c']);
                            if (temperatura <= 10) {
                              indice = 0;
                            }

                            if (temperatura > 10 && temperatura <= 22) {
                              indice = 1;
                            }

                            if (temperatura > 16 && temperatura < 22) {
                              indice = 2;
                            }

                            return Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: estadosClima[indice]['color'],
                                    borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(20),
                                        bottom: Radius.circular(20)),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          flex: 2,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 5),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 15,
                                                    width: double.infinity,
                                                    child: Text(
                                                      '${snapshot.data!['text']}',
                                                      style:
                                                          Styles.wdataTextStyle,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Text(
                                                        '${snapshot.data!['temp_c']} °C',
                                                        //-  ${snapshot.data!['temp_f']} °F
                                                        style: Styles
                                                            .wdataTempStyle,
                                                      ),
                                                      Image.network(
                                                          'https:${snapshot.data!['icon']}',
                                                          errorBuilder: ((context,
                                                                  error,
                                                                  stackTrace) =>
                                                              const Icon(Icons
                                                                  .cloud))),
                                                    ],
                                                  ),
                                                ]),
                                          )),
                                      // Expanded(
                                      //   // ignore: unnecessary_new
                                      //   child: SizedBox(
                                      //       height: 110,
                                      //       width: 120,
                                      //       child: SvgPicture.asset(
                                      //         'assets/travel2.svg',
                                      //       )),
                                      // )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  estadosClima[indice]['recomendacion'],
                                  textAlign: TextAlign.justify,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      height: 100,
                                      width: 220,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemCount: estadosClima[indice]
                                                  ['imagenes']
                                              .length,
                                          itemBuilder: ((context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                height: 50,
                                                width: 50,
                                                child: estadosClima[indice]
                                                    ['imagenes'][index],
                                              ),
                                            );
                                          })),
                                    )
                                  ],
                                )
                              ],
                            );
                          }
                          return CircularProgressIndicator(
                            color: Styles.firstColor,
                          ); //Text('Error');
                        }),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
