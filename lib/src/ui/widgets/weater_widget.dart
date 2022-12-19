import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg/avd.dart';
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
    return Row(
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
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: (double.parse(
                                        snapshot.data!['temp_c'].toString()) >
                                    15)
                                ? const Color.fromARGB(122, 29, 142, 207)
                                : const Color.fromARGB(123, 192, 154, 29),
                            borderRadius: const BorderRadius.vertical(
                                top: Radius.circular(20),
                                bottom: Radius.circular(20)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                  flex: 2,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
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
                                              style: Styles.wdataTextStyle,
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Text(
                                                '${snapshot.data!['temp_c']} °C',
                                                //-  ${snapshot.data!['temp_f']} °F
                                                style: Styles.wdataTempStyle,
                                              ),
                                              Image.network(
                                                  'https:${snapshot.data!['icon']}',
                                                  errorBuilder: ((context,
                                                          error, stackTrace) =>
                                                      const Text('Opps'))),
                                            ],
                                          ),
                                        ]),
                                  )),
                              Expanded(
                                // ignore: unnecessary_new
                                child: SizedBox(
                                    height: 110,
                                    width: 120,
                                    child: SvgPicture.asset(
                                      'assets/travel2.svg',
                                    )),
                              )
                            ],
                          ),
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
    );
  }
}
