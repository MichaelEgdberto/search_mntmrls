import 'package:flutter/material.dart';
import 'package:google_maps_webservice/directions.dart';

class DirectionsProvider extends ChangeNotifier {
  GoogleMapsDirections directionsApi =
      GoogleMapsDirections(apiKey: "AIzaSyBFZGhIalOib1q_HUF6zx58EODfQVb2Iuo");

  Set<maps.Polyline> _route = Set();
  Set<maps.Polyline> get currentRoute => _route;

  findDirections(maps.LatLng from, maps.LatLng to) async {
    var origin = Location(from.latitude, from.longitude);
    var destination = Location(to.latitude, to.longitude);
    var result = await directionsApi.directionsWithLocation(
      origin, 
      destination,
    travelMode: TravelMode.driving,);
    
    Set<maps.Polyline> newRoute = Set();
    
    if (result.isOkay) {
      var route = result.routes[0];
      var leg = route.legs[0;
      
      List<maps.LatLng> points = [];
      leg.steps.forEach((step) {
        points.add(maps.LatLng(step.startLocation.lat, step.startLocation.lng));
        points.add(maps.LatLng(step.endLocation.lat, step.endLocation.lng));
      });

      var line = maps.Polyline(
        points: points,
        polylineId: maps.PolylineId("Mejor ruta"),
        color: Colors.red,
        width: 4,);
      newRoute.add(line);
      print(line);

      _route = newRoute;
      notifyListeners();
    } else {
      print("ERROR !!! ${result.status}");
    }
  }
}