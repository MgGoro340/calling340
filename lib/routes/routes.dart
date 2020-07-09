import 'package:flutter/material.dart';
import 'package:numerologia001/pages/crear_carta.dart';
import 'package:numerologia001/pages/home_page.dart';
import 'package:numerologia001/pages/ver_carta.dart';

Map<String, WidgetBuilder> getAplicattionRoutes() {
  return <String, WidgetBuilder>{
    '/': (BuildContext context) => HomePage(),
    'crearCarta': (BuildContext context) => CrearCarta(),
    'verCarta': (BuildContext context) => VerCarta(),
    // 'avatar': (BuildContext context) => AvatarPage(),
    // 'card'  : (BuildContext context) => CardPage(),
    // 'inputs' : (BuildContext context) => InputPage(),
  };
}
