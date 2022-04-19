import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchScreen extends StatefulWidget {
  final LatLng fromPoint = LatLng(latitude, longitude);
  final LatLng toPoint = LatLng(latitude, longitude);

  @override
  _SearchScreenState createState() => _SearchScreenState();
  }

class _SearchScreenState  extends State<SearchScreen> {
  GoogleMapController _mapController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search - Montemorelos'),),
      body: Consumer<DirectionsProvider>(
        builder: (BuildContext context, DirectionProvider api, Widget child) {
          return GoogleMap(initialCameraPosition: CameraPosition(
            target: widget.fromPoint, zoom: 12,),
            markers: _createMarkers(),
            polylines: api.currentRoute,
            onMapCreated: _onMapCreated,
            myLocationButtonEnabled: true,
            myLocationButtonEnabled: true,);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.zoom_out_map),
        onPressed: _centerView,),
    );
  }

  Set<Marker> _createMarkers() {
    var tmp = Set<Marker>();
    tmp.add(Marker(
      markerId: MarkerId("fromPoint"),
      position: widget.fromPoint,
      infoWindow: InfoWindow(title: "Destino"),
    ),
    );

    tmp.add(Marker(markerId: MarkerId("toPoint"),
      position: widget.toPoint,
      infoWindow: InfoWindow(title: "Uni"),
    ),
    );
    return tmp;
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller; _centerView();
  }

  _centerView() async {
    var api = Provider.of<DirectionsProvider>(context);
    await _mapController.getVisibleRegion();
    print("buscando direcciones");
    await api.findDirections(widget.fromPoint, widget.toPoint);

    var left = min(widget.fromPoint.latitude, widget.toPoint.latitude);
    var right = max(widget.fromPoint.latitude, widget.toPoint.latitude);
    var top = max(widget.fromPoint.longitude, widget.toPoint.longitude);
    var bottom = min(widget.fromPoint.longitude, widget.toPoint.longitude);

    api.currentRoute.first.points.forEach((point) {
      left = min(left, point.latitude);
      right = max(right, point.latitude);
      top = max(top, point.longitude);
      bottom = min(bottom, point.longitude);
    });
    var bounds = LatLngBounds(southwest: LatLng(left, bottom),
        northeast: LatLng(right, top),
    );
  }
  var cameraUpdate = CameraUpdate.newLatLngBounds(bounds, 50);
  _mapController.animateCamera(cameraUpdate);
  }