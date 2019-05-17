import 'package:flutter/material.dart';
// import 'package:icps/app_screens/Locations.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MaterialApp (
    home: Airports(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class Airports extends StatefulWidget {
  @override
  _AirportsState createState() => _AirportsState();
}

class _AirportsState extends State<Airports>
{

  GoogleMapController mapController;

  // final LatLng _center = const LatLng(9.0049473, 7.2697604);
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(9.0049473, 7.2697604),
    zoom: 15.0,
  );

  void _onMapCreated(GoogleMapController controller)
  {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Color.fromRGBO(152, 160, 87, 1),
        title: new Text("Airport"),
        leading: Builder(
          builder: (context) => IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop (context);
            },
          ),
        ),
        actions: <Widget>[
          IconButton(icon: Icon(
              Icons.search
          ),
            onPressed: () {

            },
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _kGooglePlex,
      ),
    );
  }
}
