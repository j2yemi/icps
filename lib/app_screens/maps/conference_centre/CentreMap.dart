import 'package:flutter/material.dart';
// import 'package:icps/app_screens/Locations.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MaterialApp (
    home: CentreMap(),
    theme: ThemeData(
        fontFamily: 'Montserrat'
    ),
  )
  );
}

class CentreMap extends StatefulWidget {
  @override
  _CentreMapState createState() => _CentreMapState();
}

class _CentreMapState extends State<CentreMap>
{
  GoogleMapController mapController;

//  final LatLng _center = const LatLng(9.0748531, 7.4928594);

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(9.0748531, 7.4928594),
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
        title: new Text("Conference Center"),
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

enum PermissionGroup {
  /// The unknown permission only used for return type, never requested
  unknown,

  /// Android: Calendar
  /// iOS: Calendar (Events)
  calendar,

  /// Android: Camera
  /// iOS: Photos (Camera Roll and Camera)
  camera,

  /// Android: Contacts
  /// iOS: AddressBook
  contacts,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation (Always and WhenInUse)
  location,

  /// Android: Microphone
  /// iOS: Microphone
  microphone,

  /// Android: Phone
  /// iOS: Nothing
  phone,

  /// Android: Nothing
  /// iOS: Photos
  photos,

  /// Android: Nothing
  /// iOS: Reminders
  reminders,

  /// Android: Body Sensors
  /// iOS: CoreMotion
  sensors,

  /// Android: Sms
  /// iOS: Nothing
  sms,

  /// Android: External Storage
  /// iOS: Nothing
  storage,

  /// Android: Microphone
  /// iOS: Speech
  speech,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - Always
  locationAlways,

  /// Android: Fine and Coarse Location
  /// iOS: CoreLocation - WhenInUse
  locationWhenInUse,

  /// Android: None
  /// iOS: MPMediaLibrary
  mediaLibrary
}

enum PermissionStatus {
  /// Permission to access the requested feature is denied by the user.
  denied,

  /// Permissions to access the feature is granted by the user but the feature is disabled.
  disabled,

  /// Permission to access the requested feature is granted by the user.
  granted,

  /// The user granted restricted access to the requested feature (only on iOS).
  restricted,

  /// Permission is in an unknown state
  unknown
}