import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:permission_handler/permission_handler.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  GoogleMapController? mapController;
  Position? currentLocation;
  Set<Marker> markers = {};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _checkAndEnableLocation();
    _startLocationUpdates();
  }

  void _checkAndEnableLocation() {
    bool hasShownDialog = false;
    Timer.periodic(const Duration(minutes: 1), (Timer timer) async {
      var status = await Permission.location.status;
      if (!status.isGranted && !hasShownDialog) {
        await Permission.location.request();
        hasShownDialog = true;
      }
    });
  }

  void _startLocationUpdates() {
    Timer.periodic(const Duration(seconds: 10), (Timer timer) {
      _getLocation();
    });
  }

  Future<void> _getLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      setState(() {
        currentLocation = position;
      });
      _updateMarker(currentLocation!);
      _animateCamera(currentLocation!);
    } catch (error) {
      setState(() {
        _errorMessage = error.toString();
      });
    }
  }

  void _updateMarker(Position position) {
    setState(() {
      markers.clear();
      if (polylineCoordinates.isNotEmpty) {
        markers.add(Marker(
          markerId: const MarkerId('previousLocation'),
          position: polylineCoordinates.first,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
        ));
      }
      markers.add(
        Marker(
          markerId: const MarkerId('userLocation'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: 'My current location',
            snippet:
                'Latitude: ${position.latitude}, Longitude: ${position.longitude}',
          ),
        ),
      );
      _updatePolyline(position);
    });
  }

  void _updatePolyline(Position position) {
    polylineCoordinates.add(LatLng(position.latitude, position.longitude));
  }

  void _animateCamera(Position position) async {
    mapController!.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 16.0,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Real-Time Location Tracker'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Stack(
        children: [
          if (currentLocation != null)
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  currentLocation!.latitude,
                  currentLocation!.longitude,
                ),
                zoom: 16,
              ),
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
                mapController = controller;
              },
              markers: markers,
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  color: Colors.blue,
                  points: polylineCoordinates,
                ),
              },
            ),
          if (_errorMessage != null)
            Center(
              child: Text(_errorMessage!),
            ),
        ],
      ),
    );
  }
}
