

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as ph;
//import 'package:google_maps_webservice/directions.dart' as dir;

class MapPage extends StatefulWidget {
  const MapPage({super.key});
  
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  late GoogleMapController mapController;
  // double _originLatitude = 6.5212402, _originLongitude = 3.3679965;
  // double _destLatitude = 6.849660, _destLongitude = 3.648190;

  //Coordenadas del usuario
  bool gps=true;

  //coordenadas del sitio
  double _destLatitude = -13.16187972528123, _destLongitude = -74.22332704075211;

  //inicializamos el marcador ,los puntos de la direccion y nuestra apikey
  Map<MarkerId, Marker> markers = {};
  Map<PolylineId, Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();

  LocationData? currentLocation;


  String googleAPiKey = "AIzaSyBMSNja3sThI12Hko-oFOkZkDvb0zY3jUs";

  @override
  void initState() {
    
    askGpsAccess();
    /// añadimos la ubicacion a los marcadores
    
    _addPolyLine();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body:currentLocation==null?Center(child: Text("loading"),) :GoogleMap(
          initialCameraPosition: CameraPosition(
              target: LatLng(currentLocation!.latitude!,currentLocation!.longitude!), zoom: 15),
          myLocationEnabled:gps,
          tiltGesturesEnabled: true,
          compassEnabled: true,
          scrollGesturesEnabled: true,
          zoomGesturesEnabled: true,
          onMapCreated: _onMapCreated,
          markers: Set<Marker>.of(markers.values),
          polylines: Set<Polyline>.of(polylines.values),
        ),
        
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Color.fromRGBO(231, 63, 63, 1),
          onPressed: () {
            showModalBottomSheet(
                barrierColor: Color.fromARGB(185, 0, 0, 0),
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
                            title: Text("comentario 1",
                                style: TextStyle(
                                    color: Color.fromRGBO(231, 63, 63, 1))),
                            subtitle: Text(
                              "Esto es un comentario",
                              style: TextStyle(
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
                                          "https://media.revistagq.com/photos/606b3183a359af169e483dcb/16:9/w_2560%2Cc_limit/estar-guapo.jpeg"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                          ListTile(
                            title: Text("comentario 2",
                                style: TextStyle(
                                    color: Color.fromRGBO(231, 63, 63, 1))),
                            subtitle: Text(
                              "Esto es un comentario",
                              style: TextStyle(
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
                                          "https://media.revistagq.com/photos/606b3183a359af169e483dcb/16:9/w_2560%2Cc_limit/estar-guapo.jpeg"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                        ],
                      ),
                    ));
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
  void askGpsAccess()async{
    var status=await ph.Permission.location.request();
      
      if (status==ph.PermissionStatus.granted) {
        getCurrentLocation();
        setState(() => gps=false);
         
      }else{
        askGpsAccess();
      }
        
  }
  void _onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }

  void getCurrentLocation(){
    Location location=Location();
    location.getLocation().then((location){
      currentLocation=location;
      _addMarker(LatLng(currentLocation!.latitude!, currentLocation!.longitude!), "origin",
        BitmapDescriptor.defaultMarker);

    /// añadimos el sitio a los marcadores
    _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
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
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
        polylineId: id, color: Colors.red, points: polylineCoordinates);
    polylines[id] = polyline;
    setState(() {});
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(currentLocation!.latitude!, currentLocation!.latitude!),
      PointLatLng(_destLatitude, _destLongitude),
      travelMode: TravelMode.walking,
    );
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    _addPolyLine();
  }


}

 