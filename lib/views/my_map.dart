import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyMap extends StatefulWidget {
  MyMap({super.key,required this.long,required this.lat});
  double long;
  double lat;

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {

  GoogleMapController? mapController;
   Set<Marker> markers = Set<Marker>();

  @override
  void initState() {
    LatLng position = LatLng(widget.lat,widget.long);
    mapController?.moveCamera(CameraUpdate.newLatLng(position));

    final Marker marker = Marker(
      markerId: MarkerId('1212'),
      position: position,
      infoWindow: const InfoWindow(
        title: 'Sua Localização',
        snippet: 'Local do Ponto'
      )
    );

    markers.add(marker);
  }

  @override
  Widget build(BuildContext context) {
    
    void _onMapCreated(GoogleMapController controller){
      mapController = controller;
    }

    return Scaffold(
       appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Google Maps',
         style: TextStyle(color: Colors.white),
        ),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: LatLng(widget.lat,widget.long),
          zoom: 15
        ),
        markers: markers,
      )
    );
  }
}