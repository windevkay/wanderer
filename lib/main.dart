import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//providers
import './providers/greatPlaces.provider.dart';
//screens
import './screens/placesList.screen.dart';
import './screens/addPlace.screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: GreatPlaces(),
      child: MaterialApp(
          title: 'Wanderer',
          theme: ThemeData(
              primarySwatch: Colors.indigo, accentColor: Colors.amber),
          home: PlacesListScreen(),
          routes: {AddPlaceScreen.routeName: (ctx) => AddPlaceScreen()}),
    );
  }
}
