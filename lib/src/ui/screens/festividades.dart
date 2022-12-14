import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/providers/index.dart';
import 'package:walkcity/src/resources/months_repository.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/screens/calendar_page.dart';

class FestividaddesScreen extends StatelessWidget {
  const FestividaddesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final sbFestivity = Provider.of<SBFestivity>(context);
    sbFestivity.getFestivities();
    return 
    
    ListView.builder(
      itemCount:sbFestivity.festivities.length,
      itemBuilder: (context, index) {
        final festivity = sbFestivity.festivities[index];
        return Container(
            height: 150,
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(festivity.imagen!), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 28,
                  backgroundColor: Styles.fithColor,
                  child: Text(
                    festivity.dia.toString(),
                    style: const TextStyle(
                        fontSize: 30, fontWeight: FontWeight.bold),
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
                      festivity.titulo!,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 17),
                    )),
                subtitle: Container(
                  margin: EdgeInsets.only(top: 20),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: const Color.fromARGB(153, 0, 0, 0),
                  ),
                  child: Text(
                  (MonthString.getMonthString(festivity.mes!)),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                trailing: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(160, 0, 0, 0),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
                onTap: (() {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) =>
                          CalendarPage(festivity)));
                }),
              ),
            ));
      },);
    
  }
}
