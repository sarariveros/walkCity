import 'package:flutter/material.dart';
import 'package:walkcity/src/resources/festivities_repository.dart';
import 'package:walkcity/src/ui/screens/calendar_page.dart';

class FestividaddesScreen extends StatelessWidget {
  const FestividaddesScreen({super.key});

  @override
Widget build(BuildContext context) {
    return  ListView.builder(
          itemCount: festivities.length,
          itemBuilder: (context, index) {
            final festivity = festivities[index];
            return Container(
              height: 150,
                margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(festivity.image), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                  
                ),
                child: Center(
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor:const  Color.fromRGBO(255, 204, 0, .7),
                      child: Text(
                        festivity.day.toString(),
                        style: const TextStyle(fontSize: 30),
                      ),
                    ),
                    title: Container(
                        padding:
                            const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color.fromARGB(153, 0, 0, 0),
                        ),
                        child: Text(
                          festivity.title,
                          style:const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                          ),
                        )),
                    subtitle: Text(
                      festivity.montnString,
                      style:const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20
                      ),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 30,
                    ),
                    onTap: (() {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              CalendarPage(festivity)));
                    }),
                  ),
                ));
          },
    );
  }
}

