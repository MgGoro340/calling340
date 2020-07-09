//import 'dart:convert';
//import 'dart:io';

//import 'package:numerologia001/preferencias_usuario/preferencias_usuario.dart';
//import 'package:http/http.dart' as http;
//import 'package:http_parser/http_parser.dart';

import 'dart:core';

import 'package:numerologia001/models/carta_model.dart';

import 'db_provider.dart';

class CartasProvider {
  //final String _url = 'https://flutter-varios.firebaseio.com';
  //final _prefs = new PreferenciasUsuario();

  //List<CartaModel> listaDeCartas = [];

  Future<bool> crearCarta(CartaModel carta) async {


    await DBProvider.db.nuevaCarta(carta);
    
    cargarCartas();

    print('aca genero la insercion de una carta en el sqlite ');

    return true;
  }

  Future<bool> editarCarta(CartaModel carta) async {
   
    await DBProvider.db.nuevaCarta(carta);
    cargarCartas();

    return true;
  }

  Future<List<CartaModel>> cargarCartas() async {

    return await DBProvider.db.getTodosCartas();
  }

  Future<int> borrarCarta(int id) async {

    return await DBProvider.db.deleteCarta(id);
  }
}
