import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  const Map({Key? key}) : super(key: key);

  @override
  State<Map> createState() => _MapState();
}

class _MapState extends State<Map> {
  final Completer<GoogleMapController> _controller = Completer();

  void _onMapTap(LatLng location) async {
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
      height: 250,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: const CameraPosition(
          target: LatLng(13.6510651, 100.4953613),
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
          const Marker(
            markerId: MarkerId('1'),
            position: LatLng(13.6510651, 100.4953613),
            infoWindow: InfoWindow(
              title: 'Destination',
            ),
          ),
        },
        onTap: _onMapTap,
      ),
    );
  }
}
