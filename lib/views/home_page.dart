import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps/views/my_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  GoogleMapController? mapController;
  Set<Marker> makers = new Set<Marker>();
  double lat =0.00;
  double long = 0.00;
  Position? _position;

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }
  
  void _getCurrentLocation() async{
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _position = position;
      lat = position.latitude;
      long = position.longitude;
    });
  }

  @override
  void initState() {
     _getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Google Maps',
         style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: _position != null ? ElevatedButton(onPressed: (){ 
          Navigator.push(context,
            MaterialPageRoute(
              builder: (context) => MyMap(long: long, lat: lat),
            ),
          );
        }, child: Text('Bater Ponto')): const Text('Sem data'),
      )
    );
  }
}