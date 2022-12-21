import 'package:flutter/material.dart';
import 'package:walkcity/src/models/site_model.dart';
import 'package:walkcity/src/ui/screens/map/map_page.dart';

class PlacePage extends StatelessWidget {
  final Site site;

  const PlacePage({super.key, required this.site});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            site.imagen!,
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 40,
            // child: Container(
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     color: Color.fromARGB(139, 0, 0, 0),

            //   ),              
              child: MaterialButton(
                minWidth: 10,
                color: Color.fromARGB(149, 0, 0, 0),
                child: Icon(Icons.arrow_back_ios_new,color: Colors.white,size: 25,),
                onPressed: (() => Navigator.pushNamed(context, "/home"))),
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
              child: Column(children: [
                iconCategory(site.categoria!),
                Text(
                  site.nombre!,
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
              barrierColor: Color.fromARGB(151, 0, 0, 0),
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
                            site.nombre!,
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
                                        site.imagen!),
                                    fit: BoxFit.cover)),
                          ),
                          trailing: Text(
                            "",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          onTap: (() {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MapPage(site: site)));
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
//funcion Para el icono
Icon iconCategory(category){
  Icon icon=Icon(Icons.favorite,color: Color.fromARGB(255, 217, 27, 90),);
  switch (category) {
    case "1":
      icon=Icon(Icons.church,color: Colors.white,);
      break; 
    case "2":
      icon=Icon(Icons.park,color: Colors.green,);
      break; 
    case "3":
      icon=Icon(Icons.museum_sharp,color: Colors.orangeAccent,);
      break; 
    case "4":
      icon=Icon(Icons.home_work,color: Color.fromARGB(255, 218, 60, 49),);
      break;  
    default:
      icon; 
  }
  return icon;
}