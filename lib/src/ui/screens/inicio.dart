import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/models/index.dart';
import 'package:walkcity/src/providers/site_provider.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/widgets/index.dart';

class InicioScreen extends StatefulWidget {
  const InicioScreen({super.key});

  @override
  State<InicioScreen> createState() => _InicioScreenState();
}

class _InicioScreenState extends State<InicioScreen> {
  @override
  Widget build(BuildContext context) {
    final sbSite = Provider.of<SBSite>(context);
    sbSite.getcategorias();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Styles.secondColor,
                      radius: 18,
                      child: Image.asset(
                        'assets/escudo.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Ayacucho, Peru',
                      style: Styles.title,
                    ),
                  ],
                ),
                Text(
                  'Explora nuestra hermosa ciudad',
                  style: Styles.textStyle,
                ),
                FutureBuilder(
                  future: sbSite.getcategorias(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List datos = snapshot.data!;
                      return SizedBox(
                        height: MediaQuery.of(context).size.height - 185,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.vertical,
                          shrinkWrap: false,
                          itemCount: datos.length,
                          itemBuilder: (context, index) {
                            return FutureBuilder(
                              future: sbSite.getSiteByCat(datos[index].id),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  List<Site> sites = [];
                                  List data = snapshot.data!;
                                  for (var element in data) {
                                    Site site = element;
                                    sites.add(site);
                                  }

                                  return ListSites(
                                    categoria: datos[index].nombre,
                                    sites: sites,
                                  );
                                }
                                return const Text('');
                              },
                            );
                          },
                        ),
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(
                        color: Styles.firstColor,
                      ),
                    );
                  },
                )
              ],
            ),
          ],
          //bottomNavigationBar: const MenuWidget(),
        ),
      ),
    );
  }
}
