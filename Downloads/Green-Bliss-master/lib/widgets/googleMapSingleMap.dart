import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

// ignore: must_be_immutable
class GoogleMapSingleRoute extends StatefulWidget {
  List<LatLng> polylineCoordinates;
  LatLng currentLocation;
  LatLng? destinationLocation;

  GoogleMapSingleRoute(
      {super.key,
      required this.polylineCoordinates,
      required this.currentLocation,
      this.destinationLocation});
  @override
  // ignore: library_private_types_in_public_api
  _GoogleMapSingleRouteState createState() => _GoogleMapSingleRouteState();
}

class _GoogleMapSingleRouteState extends State<GoogleMapSingleRoute> {
  // ignore: unused_field
  late GoogleMapController _controllerMap;

  List<LatLng> latLng = [];

  final Set<Marker> _markers = {};

  final Set<Polyline> _polyLines = {};
  Set<Polyline> get polyLines => _polyLines;

  // ignore: unused_field
  int _polylineIdCounter = 1;

  @override
  void initState() {
    super.initState();

    if (widget.polylineCoordinates.isEmpty) {
      _getRoutePolylineSecond();
    } else {
      sendRequest();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GoogleMap(
      polylines: _polyLines,
      onMapCreated: (controller) {
        _controllerMap = controller;
      },
      markers: _markers,
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: widget.currentLocation,
        zoom: 14.0,
      ),
      mapType: MapType.normal,
    ));
  }

  Future<Polyline> _getRoutePolylineSecond() async {
    // Generates every polyline between start and finish
    final polylinePoints = PolylinePoints();
    // Holds each polyline coordinate as Lat and Lng pairs
    final List<LatLng> polylineCoordinates = [];

    final startPoint = PointLatLng(
        widget.currentLocation.latitude, widget.currentLocation.longitude);
    final finishPoint = PointLatLng(widget.destinationLocation!.latitude,
        widget.destinationLocation!.longitude);

    final result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDJP01bzEaZQqPY4V7wSils1GCTqgAFdrg",
      startPoint,
      finishPoint,
    );

    if (result.points.isNotEmpty) {
      // loop through all PointLatLng points and convert them
      // to a list of LatLng, required by the Polyline
      // ignore: avoid_function_literals_in_foreach_calls
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        );
      });
    }

    _polylineIdCounter++;

    final Polyline polyline = Polyline(
      polylineId: const PolylineId("id"),
      consumeTapEvents: true,
      points: polylineCoordinates,
      color: Colors.red,
      width: 4,
    );

    _polyLines.add(polyline);
    setState(() {});
    addMarker();
    return polyline;
  }

  void sendRequest() async {
    setSourceAndDestinationIcons();
    _getRoutePolyline();
  }

  _getRoutePolyline() async {
    _polyLines.add(Polyline(
      polylineId: const PolylineId("123"),
      consumeTapEvents: true,
      points: widget.polylineCoordinates,
      color: Colors.red,
      width: 4,
    ));
  }

  // This method is created to set the custom marker on google map for source and destination
  void setSourceAndDestinationIcons() async {
    addMarker();
  }

  // here we simply assign the bytes which we get from the icon common method to the marker
  void addMarker() {
    latLng.add(widget.currentLocation);
    setState(() {
      _markers.add(Marker(
        markerId: MarkerId(widget.currentLocation.toString()),
        position: widget.currentLocation,
      ));

      if (widget.destinationLocation != null) {
        _markers.add(Marker(
          markerId: MarkerId(widget.destinationLocation.toString()),
          position: widget.destinationLocation!,
        ));
      }
    });
  }
}
