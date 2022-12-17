import 'package:flutter/material.dart';
import 'package:walkcity/src/ui/screens/map/map_page.dart';

class PlacePage extends StatelessWidget {
  const PlacePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            "https://elcomercio.pe/resizer/0M-5L6bf9yPkkWpbDrxiK_5kSqE=/980x0/smart/filters:format(jpeg):quality(75)/arc-anglerfish-arc2-prod-elcomercio.s3.amazonaws.com/public/C2EMGTHDU5HUJOKKY3TY53HVXE.jpg",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: 300,
            right: 30,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(
                      width: 3, color: Color.fromARGB(255, 196, 158, 7)),
                  color: Colors.amber,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(children: const [
                Icon(
                  Icons.park,
                  color: Colors.green,
                ),
                Text(
                  "Parque Sucre",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromRGBO(231, 63, 63, 1),
        onPressed: () {
          showModalBottomSheet(
              barrierColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(20))),
              builder: (context) => Container(
                    height: 200,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text("Estamos Cerca",
                              style: TextStyle(
                                  color: Color.fromRGBO(231, 63, 63, 1))),
                          subtitle: Text(
                            "Parque Sucre",
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                          leading: Container(
                            width: 60,
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://elcomercio.pe/resizer/0M-5L6bf9yPkkWpbDrxiK_5kSqE=/980x0/smart/filters:format(jpeg):quality(75)/arc-anglerfish-arc2-prod-elcomercio.s3.amazonaws.com/public/C2EMGTHDU5HUJOKKY3TY53HVXE.jpg"),
                                    fit: BoxFit.cover)),
                          ),
                          trailing: Text(
                            "100m",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapPage()));
                          }),
                          title: Text(
                            "Ir al mapa",
                            style: TextStyle(
                                color: Color.fromRGBO(158, 158, 158, 1),
                                fontSize: 20),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ));
        },
        label: Text(
          "Informacion",
          style: TextStyle(fontSize: 20),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
