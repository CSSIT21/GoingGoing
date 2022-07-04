import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../models/location.dart';

class Map extends StatefulWidget {
  final Location destinationLocation;
  final Location startLocation;

  const Map(this.startLocation, this.destinationLocation, {Key? key})
      : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer();

  void _onMapTap(LatLng location) {
    CameraUpdate cameraUpdate = CameraUpdate.newCameraPosition(CameraPosition(
      target: location,
      zoom: 16,
    ));
    setState(() {
      _controller.future.then(
        (value) => value.animateCamera(cameraUpdate),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 300,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.destinationLocation.lat,
            widget.destinationLocation.lng,
          ),
          zoom: 16,
        ),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        buildingsEnabled: true,
        trafficEnabled: true,
        myLocationEnabled: true,
        myLocationButtonEnabled: false,
        markers: {
          Marker(
            markerId: const MarkerId('1'),
            position: LatLng(
              widget.destinationLocation.lat,
              widget.destinationLocation.lng,
            ),
            infoWindow: const InfoWindow(
              title: 'Destination',
            ),
          ),
          Marker(
            markerId: const MarkerId('2'),
            position: LatLng(
              widget.startLocation.lat,
              widget.startLocation.lng,
            ),
            infoWindow: const InfoWindow(
              title: 'Start',
            ),
          ),
        },
        onTap: _onMapTap,
      ),
    );
  }
}
