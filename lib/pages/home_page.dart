import 'package:flutter/material.dart';
import 'package:numerologia001/bloc/provider.dart';
import 'package:numerologia001/models/carta_model.dart';

class HomePage extends StatelessWidget {
  //const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
        ),
        //onPressed: () {   print('Hola mundo');       },
        //child: Icon(Icons.add)),
        body: _crearListado(cartasBloc));
  }

  _crearCarta(BuildContext context) {
    Navigator.pushNamed(context, 'crearCarta');
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
                leading: Icon(Icons.card_membership, color:Colors.deepPurple),
                trailing: Icon(Icons.arrow_right, color:Colors.deepPurple),
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
