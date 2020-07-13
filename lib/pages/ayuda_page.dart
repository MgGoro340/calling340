import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numerologia001/pages/home_page.dart';
import 'package:numerologia001/preferencias_usuario/preferencias_usuario.dart';

class AyudaCarta extends StatefulWidget {
  const AyudaCarta({Key key}) : super(key: key);

  @override
  _AyudaCartaState createState() => _AyudaCartaState();
}

class _AyudaCartaState extends State<AyudaCarta> {
  final PageController _pageController = PageController();
  var _opacityPage00 = 0.0;
  var _opacityPage01 = 0.0;
  var _opacityPage10 = 0.0;
  var _opacityPage11 = 0.0;
  var _opacityPage12 = 0.0;
  var _opacityPage20 = 0.0;
  var _opacityPage21 = 0.0;
  var _opacityPage22 = 0.0;
  var _opacityPage30 = 0.0;
  var _opacityPage31 = 0.0;
  var _opacityPage32 = 0.0;
  var _opacityPage40 = 0.0;
  var _opacityPage41 = 0.0;

  final List<String> _imageList = const [
    'lib/assets/ayuda/ayudaListado.png',
    'lib/assets/ayuda/ayudaNombre.png',
    'lib/assets/ayuda/ayudaFecha.png',
    'lib/assets/ayuda/ayudaCalendar.png',
    'lib/assets/ayuda/ayudaCalcularCarta.png',
    'lib/assets/ayuda/ayudaCartaFinal.png',
    'lib/assets/ayuda/ayudaVerEntidad.png',
  ];
  double _currentPage = 0;
  bool _hideIntroduction = false;

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page;
        print(
            'cambiando el page controller ' + _pageController.page.toString());
      });
    });
    super.initState();
    _onPageViewChange(0);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[],
            ),
          ),
        ),
        !_hideIntroduction
            ? Positioned(
                child: Scaffold(
                  body: buildContainerAyuda(size, context),
                ),
              )
            : Container(),
      ],
    );
  }

  Container buildContainerAyuda(Size size, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          //image: DecorationImage(image: AssetImage(_imageBG),fit: BoxFit.fill)
          color: Colors.deepPurple),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
              child: Container(
                width: size.width - 60,
                height:size.height-200,
                //height:480,
                color: Colors.white,
                child: PageView(
                  controller: _pageController,
                  children: <Widget>[
                    _pageViewChildImage1(_imageList[0]),
                    _pageViewChildImage2(_imageList[1]),
                    _pageViewChildImage3(_imageList[2]),
                    _pageViewChildImage4(_imageList[4]),
                    _pageViewChildImage5(_imageList[5]),
                    //_pageViewChildImage(_imageList[6]),
                  ],
                  onPageChanged: _onPageViewChange,
                ),
              ),
              semanticContainer: false,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5,
              margin: EdgeInsets.all(5),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _pageViewIndicator(1),
                  _pageViewIndicator(2),
                  _pageViewIndicator(3),
                  _pageViewIndicator(4),
                  _pageViewIndicator(5),
                  //_pageViewIndicator(6),
                ],
              ),
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                child: Column(
                  children: <Widget>[
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        //side: BorderSide(color: Colors.red)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            _currentPage < 4 ? 'Continuar' : 'Comencemos',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      textColor:
                          _currentPage < 4 ? Colors.deepPurple : Colors.white,
                      color: _currentPage < 4
                          ? Colors.deepPurple[100]
                          : Colors.deepPurple[800],
                      padding: EdgeInsets.all(10),
                      onPressed: () {
                        if (_pageController.page.toInt() < 3) {
                          _pageController.animateToPage(
                              _pageController.page.toInt() + 1,
                              duration: Duration(milliseconds: 200),
                              curve: Curves.easeIn);
                        } else {
                          setState(() {
                            _hideIntroduction = true;
                            //_pageController.jumpToPage(0);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          });
                        }
                      },
                    ),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                        //side: BorderSide(color: Colors.red)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Saltar presentación',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      textColor: Colors.white,
                      color: Colors.deepPurple[800],
                      padding: EdgeInsets.all(5),
                      onPressed: () {
                        final prefs = new PreferenciasUsuario();
                        prefs.initPrefs();
                        prefs.mostrarAyuda = 'no';
                        setState(() {
                          //_hideIntroduction = true;
                          //_pageController.jumpToPage(0);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomePage()));
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _onPageViewChange(int page) {
    print("Current Page: " + page.toString());
    switch (page) {
      case 0:
        {
          setState(() {
            _opacityPage00 = 1.0;
            _opacityPage10 = 0.0;
            _opacityPage11 = 0.0;
            _opacityPage12 = 0.0;
            _opacityPage20 = 0.0;
            _opacityPage21 = 0.0;
            _opacityPage22 = 0.0;
            _opacityPage30 = 0.0;
            _opacityPage31 = 0.0;
            _opacityPage32 = 0.0;
            _opacityPage40 = 0.0;
            _opacityPage41 = 0.0;
          });
          Timer(Duration(milliseconds: 1200), () {
            setState(() {
              _opacityPage01 = 1.0;
            });
          });

          break;
        }
      case 1:
        {
          setState(() {
            _opacityPage00 = 0.0;
            _opacityPage01 = 0.0;
            _opacityPage11 = 0.0;
            _opacityPage12 = 0.0;
            _opacityPage20 = 0.0;
            _opacityPage21 = 0.0;
            _opacityPage22 = 0.0;
            _opacityPage30 = 0.0;
            _opacityPage31 = 0.0;
            _opacityPage32 = 0.0;
            _opacityPage40 = 0.0;
            _opacityPage41 = 0.0;
            _opacityPage10 = 1.0;
          });
          Timer(Duration(milliseconds: 1200), () {
            setState(() {
              _opacityPage11 = 1.0;
            });
          });
          Timer(Duration(milliseconds: 1600), () {
            setState(() {
              _opacityPage12 = 1.0;
            });
          });

          break;
        }
      case 2:
        {
          setState(() {
            _opacityPage00 = 0.0;
            _opacityPage01 = 0.0;
            _opacityPage10 = 0.0;
            _opacityPage11 = 0.0;
            _opacityPage12 = 0.0;
            _opacityPage30 = 0.0;
            _opacityPage31 = 0.0;
            _opacityPage32 = 0.0;
            _opacityPage40 = 0.0;
            _opacityPage41 = 0.0;
            _opacityPage20 = 1.0;
          });
          Timer(Duration(milliseconds: 1200), () {
            setState(() {
              _opacityPage21 = 1.0;
            });
          });
          Timer(Duration(milliseconds: 1600), () {
            setState(() {
              _opacityPage22 = 1.0;
            });
          });

          break;
        }
      case 3:
        {
          setState(() {
            _opacityPage00 = 0.0;
            _opacityPage01 = 0.0;
            _opacityPage10 = 0.0;
            _opacityPage11 = 0.0;
            _opacityPage12 = 0.0;
            _opacityPage20 = 0.0;
            _opacityPage21 = 0.0;
            _opacityPage22 = 0.0;
            _opacityPage40 = 0.0;
            _opacityPage41 = 0.0;
            _opacityPage30 = 1.0;
          });
          Timer(Duration(milliseconds: 1200), () {
            setState(() {
              _opacityPage31 = 1.0;
            });
          });
          Timer(Duration(milliseconds: 1600), () {
            setState(() {
              _opacityPage32 = 1.0;
            });
          });

          break;
        }
      case 4:
        {
          setState(() {
            _opacityPage00 = 0.0;
            _opacityPage01 = 0.0;
            _opacityPage10 = 0.0;
            _opacityPage11 = 0.0;
            _opacityPage12 = 0.0;
            _opacityPage20 = 0.0;
            _opacityPage21 = 0.0;
            _opacityPage22 = 0.0;
            _opacityPage30 = 0.0;
            _opacityPage31 = 0.0;
            _opacityPage32 = 0.0;
            _opacityPage40 = 1.0;
          });
          Timer(Duration(milliseconds: 1200), () {
            setState(() {
              _opacityPage41 = 1.0;
            });
          });
          break;
        }
    }
  }

  Widget _pageViewChildImage5(String imageString) {
    return Container(
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Image.asset(
          imageString,
          fit: BoxFit.scaleDown,
        ),
        Align(
          alignment: FractionalOffset(0.99, 0.11),
          child: AnimatedOpacity(
            opacity: _opacityPage40,
            duration: Duration(milliseconds: 1500),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 1000),

              curve: Curves.easeOutExpo,
              //color: _color,
              width: 200,
              height: 30,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.arrow_left, color: Colors.white),
                        Text(
                          'Datos de la persona',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: FractionalOffset(0.95, 0.51),
          child: AnimatedOpacity(
            opacity: _opacityPage41,
            duration: Duration(milliseconds: 1500),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutExpo,
              //color: _color,
              width: 170,
              height: 60,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Icon(Icons.arrow_upward, color: Colors.white),
                    Text(
                      " Tocar 'valores' para ver detalle ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _pageViewChildImage4(String imageString) {
    return Container(
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Image.asset(
          imageString,
          fit: BoxFit.scaleDown,
        ),
        Align(
          alignment: FractionalOffset(0.85, 0.3),
          child: AnimatedOpacity(
            opacity: _opacityPage30,
            duration: Duration(milliseconds: 1500),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 1000),

              curve: Curves.easeOutExpo,
              //color: _color,
              width: 200,
              height: 30,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(Icons.arrow_left, color: Colors.white),
                        Text(
                          'Datos de la persona',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: FractionalOffset(0.95, 0.61),
          child: AnimatedOpacity(
            opacity: _opacityPage31,
            duration: Duration(milliseconds: 1500),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutExpo,
              //color: _color,
              width: 270,
              height: 100,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Icon(Icons.arrow_upward, color: Colors.white),
                    Text(
                      "Tocar 'Calcular Carta' para ver la carta \n\n Tocar 'anterior' para modificar datos ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: FractionalOffset(0.8, 0.92),
          child: AnimatedOpacity(
            opacity: _opacityPage32,
            duration: Duration(milliseconds: 1500),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutExpo,
              //color: _color,
              width: 180,
              height: 70,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Tocar para volver a \nla lista de cartas ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                    Icon(Icons.arrow_downward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _pageViewChildImage3(String imageString) {
    return Container(
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Image.asset(
          imageString,
          fit: BoxFit.scaleDown,
        ),
        Align(
          alignment: FractionalOffset(0.5, 0.15),
          child: AnimatedOpacity(
            opacity: _opacityPage20,
            duration: Duration(milliseconds: 1500),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 1000),

              curve: Curves.easeOutExpo,
              //color: _color,
              width: 290,
              height: 60,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Tocar para cargar la fecha de nacimiento',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_downward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: FractionalOffset(0.95, 0.47),
          child: AnimatedOpacity(
            opacity: _opacityPage21,
            duration: Duration(milliseconds: 1500),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutExpo,
              //color: _color,
              width: 270,
              height: 120,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Icon(Icons.arrow_upward, color: Colors.white),
                    Text(
                      "Tocar 'siguiente' para ver los datos cargados \n\n Tocar 'anterior' para el nombre de la persona ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: FractionalOffset(0.8, 0.92),
          child: AnimatedOpacity(
            opacity: _opacityPage22,
            duration: Duration(milliseconds: 1500),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutExpo,
              //color: _color,
              width: 180,
              height: 70,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Tocar para volver a \nla lista de cartas ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                    Icon(Icons.arrow_downward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _pageViewChildImage2(String imageString) {
    return Container(
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Image.asset(
          imageString,
          fit: BoxFit.scaleDown,
        ),
        Align(
          alignment: FractionalOffset(0.5, 0.15),
          child: AnimatedOpacity(
            opacity: _opacityPage10,
            duration: Duration(milliseconds: 1500),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 1000),

              curve: Curves.easeOutExpo,
              //color: _color,
              width: 240,
              height: 60,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Text(
                          'Agregar el nombre dela persona',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ],
                    ),
                    Icon(Icons.arrow_downward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: FractionalOffset(0.95, 0.47),
          child: AnimatedOpacity(
            opacity: _opacityPage11,
            duration: Duration(milliseconds: 1500),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutExpo,
              //color: _color,
              width: 180,
              height: 70,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Icon(Icons.arrow_upward, color: Colors.white),
                    Text(
                      "Tocar para cargar la \nfecha de nacimiento ",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: FractionalOffset(0.7, 0.88),
          child: AnimatedOpacity(
            opacity: _opacityPage12,
            duration: Duration(milliseconds: 1500),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutExpo,
              //color: _color,
              width: 180,
              height: 70,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Tocar para volver a \nla lista de cartas ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                    Icon(Icons.arrow_downward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _pageViewChildImage1(String imageString) {
    return Container(
      child: Stack(alignment: Alignment.center, children: <Widget>[
        Image.asset(
          imageString,
          fit: BoxFit.scaleDown,
        ),
        Align(
          alignment: FractionalOffset(0.7, 0.2),
          child: AnimatedOpacity(
            opacity: _opacityPage00,
            duration: Duration(milliseconds: 2500),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutExpo,
              //color: _color,
              width: 220,
              height: 30,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Icon(Icons.arrow_left, color: Colors.white),
                    Text(
                      'Tocar para ver el detalle ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: FractionalOffset(0.7, 0.88),
          child: AnimatedOpacity(
            opacity: _opacityPage01,
            duration: Duration(milliseconds: 1500),
            child: AnimatedContainer(
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(5.0),
              ),
              duration: Duration(milliseconds: 1000),
              curve: Curves.easeOutExpo,
              //color: _color,
              width: 180,
              height: 70,
              alignment: Alignment.center,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Tocar para agregar \n una nueva carta ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.white),
                    ),
                    Icon(Icons.arrow_downward, color: Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _pageViewIndicator(int location) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0, left: 6),
      child: Icon(Icons.lens,
          size: 14,
          color: location - 1 <= _currentPage && _currentPage < location
              ? Colors.deepPurple[100]
              : Colors.deepPurple[800]),
    );
  }
}
