import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
import 'package:walkcity/src/models/site_model.dart';
import 'package:walkcity/src/routes/routes.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/screens/index.dart';

class MapPage extends StatefulWidget {
  final Site site;

  const MapPage({super.key, required this.site});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;

  //para el tipo de mapa
  MapType mapType = MapType.normal;
  //Coordenadas del usuario
  bool gps = true;

  //coordenadas del sitio
  double? _destLatitude;
  double? _destLongitude;
  //inicializamos el marcador ,los puntos de la direccion y nuestra apikey
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  LocationData? currentLocation;

  String googleAPiKey = "AIzaSyBMSNja3sThI12Hko-oFOkZkDvb0zY3jUs";

  @override
  void initState() {

    _destLatitude = double.parse(widget.site.latitud!);
    _destLongitude = double.parse(widget.site.longitud!);

    askGpsAccess();

    /// añadimos la ubicacion a los marcadores

    _addPolyLine();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? Center(
              child: Text("loading"),
            )
          : Stack(children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                    target: LatLng(currentLocation!.latitude!,
                        currentLocation!.longitude!),
                    zoom: 15),
                mapType: mapType,
                myLocationEnabled: gps,
                tiltGesturesEnabled: true,
                compassEnabled: true,
                scrollGesturesEnabled: true,
                zoomGesturesEnabled: true,
                onMapCreated: _onMapCreated,
                markers: Set<Marker>.of(markers.values),
                polylines: Set<Polyline>.of(polylines.values),
              ),
              Positioned(
                
                  top: 30,
                  right: 15,
                  child: SpeedDial(
                    direction: SpeedDialDirection.down,
                    animatedIcon: AnimatedIcons.menu_arrow,
                    curve: Curves.easeInBack,
                    overlayColor: Color.fromARGB(151, 0, 0, 0),
                    
                    spaceBetweenChildren: 30,
                    children: [
                      SpeedDialChild(
                        label: "Normal",
                        child: Icon(
                          Icons.map,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.lightBlue,
                        shape: CircleBorder(),
                        onTap: () => setState(() {
                          mapType = MapType.normal;
                        }),
                      ),
                      SpeedDialChild(
                        label: "Satelital",
                        child: Icon(
                          Icons.satellite_alt,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.lightBlue,
                        shape: CircleBorder(),
                        onTap: () => setState(() {
                          mapType = MapType.satellite;
                        }),
                      )
                    ],
                  )),
              Positioned(
                  left: 10,
                  top: 100,
                  child: FloatingActionButton(
                    heroTag: "location",
                    shape: CircleBorder(),
                    backgroundColor: Colors.green,
                    child: Icon(gps ? Icons.gps_off : Icons.gps_fixed),
                    onPressed: (() => setState(() {
                          gps = !gps;
                        })),
                  )),
              Positioned(
                  left: 10,
                  top: 30,
                  child: FloatingActionButton(
                    heroTag: "back",
                    shape: CircleBorder(),
                    backgroundColor: Styles.secondColor,
                    child: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
                    onPressed: (() {
                      Navigator.pushNamed(context, "/home");
                    }
                  ))),
            ]),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        heroTag: "comments",
        backgroundColor: Color.fromRGBO(231, 63, 63, 1),
        onPressed: () {
          Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ComentsPage(idSite: widget.site,)));
          // showModalBottomSheet(
          //     barrierColor: Color.fromARGB(185, 0, 0, 0),
          //     context: context,
          //     isScrollControlled: true,
          //     shape: const RoundedRectangleBorder(
          //         borderRadius:
          //             BorderRadius.vertical(top: Radius.circular(20))),
          //     builder: (context) => Container(
          //           height: 200,
          //           child: Column(
          //             children: [
          //               const SizedBox(
          //                 height: 20,
          //               ),
          //               ListTile(
          //                 title: const Text("comentario 1",
          //                     style: TextStyle(
          //                         color: Color.fromRGBO(231, 63, 63, 1))),
          //                 subtitle: const Text(
          //                   "Esto es un comentario",
          //                   style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.black),
          //                 ),
          //                 leading: Container(
          //                   width: 60,
          //                   height: 60,
          //                   decoration: BoxDecoration(
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(10)),
          //                       image: DecorationImage(
          //                           image: NetworkImage(
          //                               "https://media.revistagq.com/photos/606b3183a359af169e483dcb/16:9/w_2560%2Cc_limit/estar-guapo.jpeg"),
          //                           fit: BoxFit.cover)),
          //                 ),
          //               ),
          //               ListTile(
          //                 title: Text("comentario 2",
          //                     style: TextStyle(
          //                         color: Color.fromRGBO(231, 63, 63, 1))),
          //                 subtitle: Text(
          //                   "Esto es un comentario",
          //                   style: TextStyle(
          //                       fontWeight: FontWeight.bold,
          //                       color: Colors.black),
          //                 ),
          //                 leading: Container(
          //                   width: 60,
          //                   height: 60,
          //                   decoration: BoxDecoration(
          //                       borderRadius:
          //                           BorderRadius.all(Radius.circular(10)),
          //                       image: DecorationImage(
          //                           image: NetworkImage(
          //                               "https://media.revistagq.com/photos/606b3183a359af169e483dcb/16:9/w_2560%2Cc_limit/estar-guapo.jpeg"),
          //                           fit: BoxFit.cover)),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ));
        },
        label: Text(
          "Comentarios",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }

//Funciones

  //para pedir permsos de ubicacion
  void askGpsAccess() async {
    var status = await ph.Permission.location.request();

    if (status == ph.PermissionStatus.granted) {
      getCurrentLocation();
      setState(() => gps = false);
    } else {
      askGpsAccess();
    }
  }

  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((location) {
      currentLocation = location;
      _addMarker(
          LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          "Tu",
          BitmapDescriptor.defaultMarker);

      /// añadimos el sitio a los marcadores
      _addMarker(LatLng(_destLatitude!, _destLongitude!), widget.site.nombre!,
          BitmapDescriptor.defaultMarkerWithHue(90));

      //obtenemos los puntos de la direccion
      _getPolyline();
    });
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker =
        Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine() {
    PolylineId id = PolylineId("Camino");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.red,
      points: polylineCoordinates,
      width: 4,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      PointLatLng(_destLatitude!, _destLongitude!),
      travelMode: TravelMode.walking,
    );
    print("Esrte es el result $result");

    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }
}
