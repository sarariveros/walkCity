import 'package:flutter/material.dart';
import 'package:walkcity/src/providers/index.dart';
import 'package:walkcity/src/styles/style.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    Key? key,
    // required this.weatherProvider,
  }) : super(key: key);

  // final WeaterApiProvider weatherProvider;

  @override
  Widget build(BuildContext context) {
    final weatherProvider = WeaterApiProvider();
    // Provider.of<WeaterApiProvider>(context, listen: false);
    return Container(
      height: 170,
      width: double.infinity,
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://cdn.pixabay.com/photo/2019/03/16/04/49/mountain-4058445_960_720.jpg'),
            fit: BoxFit.fill),
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(20), bottom: Radius.circular(20)),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Color.fromARGB(123, 192, 154, 29),
          borderRadius: BorderRadius.vertical(
              top: Radius.circular(20), bottom: Radius.circular(20)),
        ),
        child: Column(
          children: [
            Text(
              'Recorre nuestra ciudad',
              style: Styles.wTitleStyle,
            ),
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
                                //  print(snapshot.data);
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Clima Actual',
                                      style: Styles.sitecardTStyle,
                                    ),
                                    Text(
                                      '${snapshot.data!['temp_c']} °C  -  ${snapshot.data!['temp_f']} °F ',
                                      style: Styles.wdataTempStyle,
                                    ),
                                    SizedBox(
                                      height: 30,
                                      width: 150,
                                      child: Text(
                                        '${snapshot.data!['text']}',
                                        style: Styles.wdataTextStyle,
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    // Image.network('${snapshot.data!['icon']}',
                                    //     errorBuilder: ((context, error, stackTrace) =>
                                    //         Text('data')))
                                  ],
                                );
                              }
                              return const CircularProgressIndicator(); //Text('Error');
                            }),
                      ],
                    ),
                  ),
                ),
                const Expanded(
                  child: SizedBox(
                    height: 110,
                    // width: 120,
                    child: Image(
                      //color: Colors.red,
                      image: NetworkImage(
                          'https://cdn.pixabay.com/photo/2014/04/02/10/41/bus-304248_960_720.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
