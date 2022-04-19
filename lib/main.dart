import 'package:flutter/material.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotiferProvider(
        builder: (_) = DirectionsProvider(),
    child: MaterialApp(
      title: 'Fluter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: SearchScreen(),
    ),);
  }
}

class AskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Search - Mntmrls'),),
      body: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text('Desde: Tu ubicacion',),
          Text('Hasta: destino',),
          FlatButton(child: Text("Aceptar Viaje"), onPressed: (){},
          )
        ],
      ),),
    );
  }
}
