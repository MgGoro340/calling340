import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numerologia001/pages/ayuda_page.dart';
import 'package:numerologia001/pages/home_page.dart';
import 'package:numerologia001/preferencias_usuario/preferencias_usuario.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var _color = Colors.deepPurpleAccent;
  var _widthOriginal = 200.0;
  var _heightOriginal = 100.0;

  var _widthFinal = 200.0;
  var _heightFinal = 100.0;

  var _widthCircle = 1.0;
  var _heigthCircle = 1.0;

  var _opacity = 0.0;

  _SplashScreenState() {
    Timer(Duration(milliseconds: 200), () {
      //Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()) );
      animarTarjeta();
    });
    Timer(Duration(milliseconds: 1200), () {
      animarCirculo();
    });
  }
  @override
  void initState() {
    super.initState();

    Timer(Duration(seconds: 5), () {
      final prefs = new PreferenciasUsuario();
      prefs.initPrefs();

      var _mostrarAyuda = prefs.mostrarAyuda;

      if (_mostrarAyuda == 'si') {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => AyudaCarta()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }

      //print('llamo a home page');
    });
  }

  animarCirculo() {
    setState(() {
      _opacity = _opacity == 0.0 ? 1.0 : 0.0;
      _widthCircle = 1000.0;
      _heigthCircle = 1000.0;
    });
  }

  animarTarjeta() {
    setState(() {
      //_color = _color == Colors.deepPurpleAccent          ? Colors.white      : Colors.deepPurpleAccent;
      //_color = Colors.white;
      _widthOriginal = _widthFinal + 100;
      _heightOriginal = _heightFinal + 100;
    });
  }

  @override
  Widget build(BuildContext context) {
    _widthFinal = MediaQuery.of(context).size.width;
    _heightFinal = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      body: Container(
        // alignment: Alignment.center,
        child: Stack(children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: _color,
                //border: Border.all(color: Colors.orange, width: 5), // added
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 2000),
              curve: Curves.easeOutExpo,
              //color: _color,
              width: _widthOriginal,
              height: _heightOriginal,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                //duration: Duration(seconds: 3),
                //color: _color,
                //width: _widthOriginal,
                //height: _heightOriginal,
                //alignment: Alignment.center,
                child: Text(
                  '340',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 50,
                      color: Colors.white),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: AnimatedContainer(
              alignment: Alignment.center,
              duration: Duration(seconds: 1),
              child: Text(
                '340',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 50,
                    color: Colors.deepPurple),
              ),
              width: _widthCircle,
              height: _heigthCircle,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                //borderRadius: BorderRadius.circular(5.0),
              ),
            ),
          ),
          Align(
            alignment: FractionalOffset(0.5, 0.85),
            child: AnimatedOpacity(
              opacity: _opacity,
              duration: Duration(seconds: 3),
              child: Text(
                'Cartas Numerologicas',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
