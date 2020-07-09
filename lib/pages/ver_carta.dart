import 'package:flutter/material.dart';
import 'package:numerologia001/bloc/provider.dart';
import 'package:numerologia001/models/carta_model.dart';

class VerCarta extends StatefulWidget {
  const VerCarta({Key key}) : super(key: key);

  @override
  _VerCartaState createState() => _VerCartaState();
}

class _VerCartaState extends State<VerCarta> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  CartasBloc cartasBloc;
  CartaModel carta = new CartaModel();
  //bool _guardando = false;

  TextEditingController _fechaEditingController = new TextEditingController();
  String _fecha = '';
  //String _nombre = '';

  @override
  Widget build(BuildContext context) {
    cartasBloc = Provider.cartasBloc(context);

    final CartaModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      carta = prodData;
    } else {
      carta.fechaNacimiento = '02/10/1973';
    }

    return Scaffold(
      appBar: AppBar(
        title: crearTituloAppBar(),
      ),
      floatingActionButton: 
        FloatingActionButton(
          onPressed: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back),
          backgroundColor: Colors.deepPurple
          ),
      body: // ListView(
          //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          Container(
        //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        child: Card(
          child: Column(
            //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.card_membership, color:Colors.deepPurple),
                title: nombrePersona(),
                subtitle: fechaPersona(),
              ),
              Wrap(
                children: <Widget>[
                  mostrarEntidad('${carta.caminoVida}'  , 'Camino de vida '),
                  mostrarEntidad('${carta.nacimiento}'  , 'Nacimiento '),
                  mostrarEntidad('${carta.caminoAlma}'  , 'Camino de alma '),
                  mostrarEntidad('${carta.personalidad}', 'Personalidad '),
                  mostrarEntidad('${carta.temperamento}', 'Temperamento '),
                  mostrarEntidad('${carta.mision}'      , 'Mision '),
                  mostrarEntidad('${carta.metaFinal}'   , 'Meta Final '),
                ],
              ),
              Expanded(
                child: Container(
                    margin: EdgeInsets.all(10.0),
                    alignment: Alignment.center,
                    //color: Colors.amberAccent,
                    child: generarListaImagens()),
              ),
             
            ],
          ),
        ),
      ),
    );
  }

  Widget generarListaImagens() {
    return ListView(
      padding: EdgeInsets.all(5.0),
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        buildExpandedImagenes('${carta.caminoVida}'   ,'Camino de vida '),
        buildExpandedImagenes('${carta.nacimiento}'   ,'Nacimiento '),
        buildExpandedImagenes('${carta.caminoAlma}'   ,'Camino de alma '),
        buildExpandedImagenes('${carta.personalidad}' ,'Personalidad '),
        buildExpandedImagenes('${carta.temperamento}' ,'Temperamento '),
        buildExpandedImagenes('${carta.mision}'       , 'Mision '),
        buildExpandedImagenes('${carta.metaFinal}'    , 'Meta Final '),
       // buildExpandedImagenes('7'),
      ],
    );
  }

  Widget buildExpandedImagenes(String valor, String dimension ) {
    final _miCard = Expanded(
      child: Container(
        margin: EdgeInsets.all(1.0),
        alignment: Alignment.center,
        //margin: EdgeInsets.only(right:10.0),
        // color: Colors.purple[100],
        child: Column(
          children: <Widget>[
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: FadeInImage(
                  image: AssetImage('lib/assets/Tarot$valor.jpg'),
                  placeholder: AssetImage('lib/assets/loading.gif'),
                  fadeInDuration: Duration(milliseconds: 450),

                  ///height: 150.0,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5.0),
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                color: Colors.deepPurple[200],
                borderRadius: BorderRadius.circular(40.0),
              
              ),
              child: Text(
                '$dimension  $valor',
                overflow: TextOverflow.ellipsis,
                 style: TextStyle(
                   fontWeight: FontWeight.bold, 
                   fontSize: 18,
                   color: Colors.deepPurple)
              ),
             )
             
          ],
        ),
      ),
    );

    return _miCard;
  }

  Chip mostrarEntidad(String valor, String texto) {
    return Chip(
      padding: EdgeInsets.all(5.0),
      avatar: CircleAvatar(
        backgroundColor: Colors.deepPurple,
        radius: 40.0,
        child: Text(valor,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
      ),
      label: Text(texto),
      backgroundColor: Colors.purple[200],
    );
  }


   Widget nombrePersona() {
     return Text('${carta.nombre}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18));
   }

  Widget fechaPersona() {
    return Text(
        '${carta.fechaNacimiento}  -  ${carta.caminoVida} en ${carta.nacimiento}',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12));
  }

  Widget crearTituloAppBar() {
    return Text('Carta: ${carta.nombre}');
  }

  Widget nombreCaminoVida() {
    //return Text('Camino de vida ${carta.caminoVida}');
    return Text('${carta.caminoVida}');
  }
}
