import 'package:flutter/material.dart';
import 'package:numerologia001/pages/crear_carta.dart';
import 'package:numerologia001/pages/home_page.dart';
import 'package:numerologia001/pages/splash.dart';
import 'package:numerologia001/pages/ver_carta.dart';

Map<String, WidgetBuilder> getAplicattionRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => SplashScreen(),
    'home': (BuildContext context) => HomePage(),
    'crearCarta': (BuildContext context) => CrearCarta(),
    'verCarta': (BuildContext context) => VerCarta(),
     'splash': (BuildContext context) => SplashScreen(),
    // 'card'  : (BuildContext context) => CardPage(),
    // 'inputs' : (BuildContext context) => InputPage(),
  };
}
