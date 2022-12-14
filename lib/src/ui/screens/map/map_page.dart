
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
//import 'package:google_maps_webservice/directions.dart' as dir;
import 'package:location/location.dart' as lc;
import 'package:permission_handler/permission_handler.dart';


class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng position = LatLng(-13.15878, -74.22321);
  late GoogleMapController controller;
  // Para cambiar el tipo de mapa
  MapType mapType = MapType.normal;
  late lc.Location location;

  //intanciar la ruta
  // Set<Polyline> _route=Set();
  // dir.GoogleMapsDirections directionApi=dir.GoogleMapsDirections(
  //   apiKey: "AIzaSyBMSNja3sThI12Hko-oFOkZkDvb0zY3jUs",
  // );


  // //Para buscar crear la ruta
  // findDirections(LatLng inicio,LatLng fin)async{
  //   var origin=dir.Location(inicio.latitude,fin.longitude);
  //   var destination=dir.Location(fin.latitude,fin.longitude);

  //   var result=await directionApi.directionsWithLocation(origin, destination);

  //   Set<Polyline> newRoute=Set();

  //   if(result.isOkay){
  //     var route=result.routes[0];
  //     var leg=route.legs[0];

  //     List<LatLng>points=[];
  //     leg.steps.forEach((step) { 
  //       points.add(LatLng(step.startLocation.lat, step.startLocation.lng));
  //       points.add(LatLng(step.endLocation.lat, step.endLocation.lng));
  //     });

  //     var line=Polyline(
  //       points: points,
  //       polylineId: PolylineId("ESta es la ruta"),
  //       color: Colors.red,  
  //     );
  //     newRoute.add(line);
  //     _route=newRoute;
        
        
  //   }
  // }




  //para la ubicacion actual
  bool myLocationEnabled=false;
  bool myLocationButtonEnabled=false;
  LatLng currentLocation=LatLng(-13.15878, -74.22321);
  
  //para el controlador
  onMapCreated(GoogleMapController controller){
    this.controller=controller;
    _centerView();
  }
  //para centrar la camera
  _centerView()async{
    await controller..getVisibleRegion();

    var left =min(currentLocation.latitude,position.latitude);
    var right=max(currentLocation.latitude,position.latitude);
    var top=max(currentLocation.longitude,position.longitude);
    var bottom=min(currentLocation.longitude,position.longitude);

    var bounds=LatLngBounds(southwest: LatLng(left,bottom), northeast: LatLng(right,top));

    var cameraUpdate=CameraUpdate.newLatLngBounds(bounds, 50);
    controller.animateCamera(cameraUpdate);
  }
  
  //para pedir permiso al usuario
  requestPermission() async {
    Map<Permission, PermissionStatus> statuses =
        await [Permission.locationAlways].request();

    var status = statuses[Permission.locationAlways];
    if (status == PermissionStatus.denied) {
      requestPermission();
    } else {
      enableGPS();
    }
  }

  enableGPS() async {
    location =lc.Location();
    bool serviceStatusResult = await location.requestService();
    if (!serviceStatusResult) {
      enableGPS();
    } else {
      updateStatus();
      getLocation();
      //locationChanged();
    }
  }

  //para actuaizar la ubicacion
  updateStatus(){
    setState(() {
      myLocationEnabled=true;
      myLocationButtonEnabled=true;
    });
  }
  //para obtener la ubicacion del usuario actual
  getLocation()async{
    var currentLocation=await location.getLocation();
    updateLocation(currentLocation);

  }
  updateLocation( currentLocation){
    if (currentLocation!=null) {
      
      setState(() {
        this.currentLocation= LatLng(currentLocation.latitude,currentLocation.longitude);
        // this.controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: this.currentLocation,zoom:17)));
        _centerView();
        
      });
    } 
  }
  //para obtener cosntantemente la ubicacion del usuario


  locationChanged(){
    location.onLocationChanged.listen((lc.LocationData cLoc){
      if(cLoc!=null){
        updateLocation(currentLocation);
      }
    });
  }


  @override
  void initState() {
    super.initState();
    requestPermission();

  }
  
  
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          initialCameraPosition: CameraPosition(
            target: position,
            zoom: 14,
          ),

          myLocationEnabled: myLocationEnabled,
          myLocationButtonEnabled: myLocationButtonEnabled,
          mapType: mapType,
          markers: {
            Marker(
              markerId: MarkerId(position.toString()),
              infoWindow: InfoWindow(title: "Lugar"),
              position: position,
              //para que el usuario mueva el marcador
              //draggable: true,
            ),
           Marker(
              markerId: MarkerId("mio"),
              position:LatLng(-13.15878, -77.34),
              //para que el usuario mueva el marcador
              //draggable: true,
            ),
           
          },
          //polylines: _route,
          onMapCreated:onMapCreated,
        ),
      ]),
      // floatingActionButton: SpeedDial(
      //   direction: SpeedDialDirection.down,
      //   animatedIcon: AnimatedIcons.menu_close,
      //   overlayColor: Colors.black,
      //   overlayOpacity: 0.5,
      //   elevation: 8.0,
      //   children: [
      //     SpeedDialChild(
      //         labelStyle: TextStyle(),
      //         child: Icon(Icons.room),
      //         label: "normal",
      //         onTap: (() {
      //           setState(() => mapType = MapType.normal);
      //         })),
      //     SpeedDialChild(
      //         label: "satelital",
      //         child: Icon(Icons.satellite),
      //         onTap: (() {
      //           setState(() => mapType = MapType.satellite);
      //         })),
      //     SpeedDialChild(
      //         label: "hibrido",
      //         child: Icon(Icons.compare),
      //         onTap: (() {
      //           setState(() => mapType = MapType.hybrid);
      //         })),
      //     SpeedDialChild(
      //         label: "centrar",
      //         child: Icon(Icons.zoom_out_map),
      //         onTap: (() {
      //           _centerView();
      //           //findDirections(currentLocation, position);
      //         })),

      //   ],
      // ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Color.fromRGBO(231, 63, 63,1),
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
        label: Text("Comentarios",style: TextStyle(fontSize: 20),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      

    );
  }
}
