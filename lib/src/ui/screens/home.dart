import 'package:flutter/material.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/widgets/index.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  void onItemTapped(int index) {}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('WalkCity'),
      //   centerTitle: true,
      // ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '¿Listo?',
                    style: Styles.textStyleB,
                  ),
                  Text('Ayacucho, Peru'),
                ],
              ),
              Container(
                height: 180,
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
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.notifications,
                            ),
                            color: Colors.white,
                          ),
                          Text(
                            'Recorre nuestra ciudad',
                            style: Styles.sitecardTStyle,
                          ),
                          Text(
                            '14:24 pm',
                            style: Styles.sitecardTStyle,
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          SizedBox(
                            height: 110,
                            width: 150,
                            child: Image(
                              image: NetworkImage(
                                  'https://cdn.pixabay.com/photo/2014/04/02/10/41/bus-304248_960_720.png'),
                              fit: BoxFit.contain,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Text(
                'Sitios',
                style: Styles.textStyle,
              ),
              const ListSites(clasificacion: 'Iglesias'),
              const ListSites(clasificacion: 'Parques'),
              const ListSites(clasificacion: 'Museos'),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.newspaper), label: 'Events'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'News'),
          BottomNavigationBarItem(
              icon: Icon(Icons.people),
              // CircleAvatar(
              //   backgroundImage: NetworkImage(
              //       'https://cdn.pixabay.com/photo/2021/05/23/00/21/woman-6274879_960_720.png'),
              //   radius: 15,
              // ),
              label: 'Profile'),
        ],
        // currentIndex: _selectedIndex,
        onTap: onItemTapped,
      ),
    );
  }
}
