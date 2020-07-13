import 'package:flutter/material.dart';
import 'package:numerologia001/pages/ayuda_page.dart';
import 'package:numerologia001/pages/crear_carta_nombre.dart';
import 'package:numerologia001/pages/home_page.dart';
import 'package:numerologia001/pages/splash.dart';
import 'package:numerologia001/pages/ver_carta.dart';

Map<String, WidgetBuilder> getAplicattionRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => SplashScreen(),
    'home': (BuildContext context) => HomePage(),
    'crearCartaNombre': (BuildContext context) => CrearCartaNombre(),
    //'crearCartaFecha': (BuildContext context) => CrearCartaF(),
    'verCarta': (BuildContext context) => VerCarta(),
     'splash': (BuildContext context) => SplashScreen(),
     'ayuda'  : (BuildContext context) => AyudaCarta(),
    // 'inputs' : (BuildContext context) => InputPage(),
  };
}
