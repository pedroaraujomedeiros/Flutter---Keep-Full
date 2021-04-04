import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_webservice/places.dart';

class MapTab extends StatefulWidget {
  @override
  _MapTabState createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  /// Geolocator
  Geolocator _geolocator = Geolocator();

  /// Google Map Controller
  GoogleMapController _controller;
  /// Device Position
  Position _devicePosition;
  /// icon of the device that will be shown on map
  BitmapDescriptor _iconDevice;
  /// Device Marker
  Marker _deviceMarker;

  /// Collection of markers shown on map
  /// Obs: Set is a collection as List, however
  /// each object can occur only once within a Set
  final Set<Marker> _markers = Set<Marker>();

  /// Options for get a new position of the device
  /// accuracy: LocationAccuracy.high
  /// distanceFilter: 100 meters
  var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 100);

  ///Returns bytes of the icon that should be used for the device marker
  Future<Uint8List> _getIconDevice() async{
    ByteData byteData= await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  ///Get current device's position
  Future<Position> _getDevicePosition() async{
    try {
      Position position = await _geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      return position;
    } on Exception {
      return null;
    }
  }

  /// Set device position property according each position receiver
  /// from geolocator listener
  void _setDevicePosition(Position devicePosition) async {

     if(devicePosition != null ){
      setState(() {
        this._devicePosition = devicePosition;
      });

      if(_controller != null){
        double zoom = await _controller.getZoomLevel();
        /// Move map to the new position
        _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            target: _devicePosition == null
                    ? LatLng(0, 0)
                    : LatLng(_devicePosition.latitude, _devicePosition.longitude), zoom: zoom)));
      }

      Uint8List iconMarker = await _getIconDevice();

      /// Create new marker for representing the device
      /// based on the new position
      this._deviceMarker = Marker(
        markerId: MarkerId("markerDevice"),
        position: LatLng(_devicePosition.latitude, _devicePosition.longitude),
        icon: this._iconDevice ,
        draggable: false,
        zIndex: 2,
        flat: true,
        rotation: this._devicePosition.heading,
      );
      this._markers.clear();
      setState(()  {
        this._markers.add(this._deviceMarker);
      });

      /// Get grocery stores nearby the new position
      this.getNearbyGroceryStores(LatLng(_devicePosition.latitude, _devicePosition.longitude));
    }

  }

  /// Check GPS Permission
  void _checkGPSPermission() {
    _geolocator.checkGeolocationPermissionStatus().then((status) {  });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationAlways).then((status) {  });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationWhenInUse)..then((status) { });
  }

  @override
  void initState() {
    super.initState();
    _checkGPSPermission();

    BitmapDescriptor
        .fromAssetImage(ImageConfiguration( size: Size(5,12)),"assets/images/car_icon.png")
        .then(
            (value) {
              this._iconDevice = value;
            });

    /// Get current device position
    _getDevicePosition().then((position) {
      this._setDevicePosition(position);
    });

    /// Add event listener
    _geolocator.getPositionStream(locationOptions).listen((Position position) {
      if (position != null) {
        this._setDevicePosition(position);
      }
    });
  }



  @override
  Widget build(BuildContext context) {

    return this._devicePosition == null
        ? Container(
            child: Center(
              child: Text(
                "Loading Map...",
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
            ),
          )
        : Container(
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(_devicePosition.latitude, _devicePosition.longitude),
                zoom: 13.0,
              ),
              onMapCreated: _onMapCreated,
              markers: _markers,
            ),
    );
  }

  /// Set Google Maps controller once the map is created
  /// See Google Maps package documentation
  void _onMapCreated(GoogleMapController controller) async {
    _controller = controller;
  }

  /// Get Nearby Grocery Stores and show on map
  /// Radius considered = 1500 meters
  Future<void> getNearbyGroceryStores(LatLng deviceLocation) async {
    try{
      final places = new GoogleMapsPlaces(apiKey: "YOUR_GOOGLE_MAPS_API_KEY");

      String nextPageToken;
      final Set<Marker> newMarkers = Set<Marker>();

      do {

        PlacesSearchResponse response = nextPageToken == null
            ? await places.searchNearbyWithRadius(
          Location(deviceLocation.latitude, deviceLocation.longitude),
          1500,
          keyword: "grocery",
        )
            : await places.searchNearbyWithRadius(
            Location(deviceLocation.latitude, deviceLocation.longitude),
            1500,
            keyword: "grocery",
            pagetoken: nextPageToken);
        if (response.status == "OK") {
          response.results.forEach((f) async {
            final marker = Marker(
              markerId: MarkerId(f.placeId),
              position: LatLng(f.geometry.location.lat, f.geometry.location.lng),
              infoWindow: InfoWindow(title: "${f.name}"),
            );

            newMarkers.add(marker);

          });
        } else {
          nextPageToken = null;
        }
      } while (nextPageToken != null);

      /// Set state in order to rebuild the map with the new collection of markers
      setState(() {
        this._markers.addAll(newMarkers);
      });
    }
    catch (error) {

    }

  }
}
