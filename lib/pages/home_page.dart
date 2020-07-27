import 'package:flutter/material.dart';
import 'package:numerologia001/bloc/provider.dart';
import 'package:numerologia001/models/carta_model.dart';
import 'package:numerologia001/pages/choices.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  BuildContext _context;

  List<Choice> choices = const <Choice>[
    Choice(title: 'Ayuda', icon: Icons.help),
    Choice(title: 'Acerca de..', icon: Icons.code),
  ];

  @override
  Widget build(BuildContext context) {
    _context = context;
    final cartasBloc = Provider.cartasBloc(context);
    cartasBloc.cargarCartas();

    return new Scaffold(
        floatingActionButton: FloatingActionButton.extended(
            label: Text('Agregar Carta'),
            onPressed: () => _crearCarta(context),
            icon: Icon(Icons.add),
            backgroundColor: Colors.deepPurple),
        appBar: AppBar(
          title: Text("Cartas Numerologicas"),
          automaticallyImplyLeading: false,
          actions: <Widget>[
            // overflow menu
            PopupMenuButton<Choice>(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: _crearListado(cartasBloc));
  }

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.

    //print('Seleccionado ${choice.title}');

    if (choice.title == 'Ayuda') {
      Navigator.pushNamed(_context, 'ayuda');
    }
    if (choice.title == 'Acerca de..') {
      mostrarAbout();
    }
  }

  void mostrarAbout() {
    showDialog(
        context: _context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            title: Text(
              'Acerca de...',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.deepPurple),
            ),
            content: Container(
              height:  400,
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'lib/assets/icon/ic_launcher340.png',
                        fit: BoxFit.scaleDown,
                      ),
                    ],
                  ),
                  Row(
                     children: <Widget>[
                       SizedBox(
                        height: 25.0,
                        //child: const Card(child: Text('Hello World!')),
                  ),
                     ],
                   ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Creador : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.deepPurple),
                      ),
                      Text(
                        ' Martín Goró',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _launchURL('https://www.linkedin.com/in/martingoro/');
                        },
                        child: Text(
                          'https://www.linkedin.com/in/martingoro/',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.deepPurple),
                        ),
                      ),
                    ],
                  ),
                   Row(
                     children: <Widget>[
                       SizedBox(
                        height: 30.0,
                        //child: const Card(child: Text('Hello World!')),
                  ),
                     ],
                   ),
                  Row(
                    children: <Widget>[
                      Text(
                        'Dibujos : ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Colors.deepPurple),
                      ),
                      Text(
                        ' Sofía Goró',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.deepPurple),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _launchURL('https://www.instagram.com/soygorroahre/');
                        },
                         child: Text(
                          'https://www.instagram.com/soygorroahre/',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                              color: Colors.deepPurple),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: [
              Container(
                margin: EdgeInsets.all(20),
                child: FlatButton(
                  child: Text('   volver   '),
                  color: Colors.deepPurple,
                  textColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                    //side: BorderSide(color: Colors.red)
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
            ],
          );
        });
  }

  _launchURL(String miUrl) async {
    //const url = 'https://www.linkedin.com/in/martingoro/';
    if (await canLaunch(miUrl)) {
      await launch(miUrl);
    } else {
      throw 'Could not launch $miUrl';
    }
  }

  _crearCarta(BuildContext context) {
    Navigator.pushNamed(context, 'crearCartaNombre');
    //print('Hola mundo');
  }


  Widget _crearListado(CartasBloc cartasBloc) {
    print(' _crearListado en el stream builder ');
    return StreamBuilder(
      stream: cartasBloc.cartasStream,
      builder:
          (BuildContext context, AsyncSnapshot<List<CartaModel>> snapshot) {
        if (snapshot.hasData) {
          final cartas = snapshot.data;
          //print(' _crearListado en el builder dibujando como loco ');
          return ListView.builder(
            itemCount: cartas.length,
            itemBuilder: (context, i) =>
                _crearItem(context, cartasBloc, cartas[i]),
          );
        } else {
          //print(' _crearListado en el builder no dibujo porque no hay datos ');
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(
      BuildContext context, CartasBloc cartasBloc, CartaModel carta) {
    return Dismissible(
        key: UniqueKey(),
        background: Container(
            // color: Colors.red,
            ),
        onDismissed: (direccion) => cartasBloc.borrarCarta(carta.id),
        child: Card(
          child: Column(
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.card_membership, color: Colors.deepPurple),
                trailing: Icon(Icons.arrow_right, color: Colors.deepPurple),
                title: Text('${carta.nombre} - ${carta.fechaNacimiento}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.deepPurple)),
                subtitle: Text(' Camino del alma ${carta.caminoAlma} ',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.deepPurple[600])),
                onTap: () =>
                    Navigator.pushNamed(context, 'verCarta', arguments: carta),
              ),
            ],
          ),
        ));
  }
}
