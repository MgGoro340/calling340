import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:numerologia001/bloc/provider.dart';
import 'package:numerologia001/models/carta_model.dart';
import 'package:numerologia001/utils/calculo_carta.dart';
import 'package:intl/intl.dart';

class CrearCarta extends StatefulWidget {
  const CrearCarta({Key key}) : super(key: key);

  @override
  _CrearCartaState createState() => _CrearCartaState();
}

class _CrearCartaState extends State<CrearCarta> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  CartasBloc cartasBloc;
  CartaModel carta = new CartaModel();
  //bool _guardando = false;

  TextEditingController _fechaEditingController = new TextEditingController();
  //TextEditingController _nombreEditingController = new TextEditingController();
  String _fecha = '';
  String _nombre = '';
  //String _nombre = '';

  @override
  Widget build(BuildContext context) {
    cartasBloc = Provider.cartasBloc(context);
    _fechaEditingController.text = '';
    //_nombreEditingController.text = '';
    final CartaModel prodData = ModalRoute.of(context).settings.arguments;
    if (prodData != null) {
      carta = prodData;
      //} else {
      //  carta.fechaNacimiento = '02/10/1973';
    }

    return Scaffold(
        appBar: AppBar(
          title: Text("Crear carta"),
        ),
        body: // ListView(
            //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Form(
                    key: formKey,
                    child: ListView(
                      children: <Widget>[
                        _crearPersona(),
                        Divider(),
                        _crearFecha(context),
                        Divider(),
                        Container(
                          margin: EdgeInsets.all(20),
                          child: FlatButton(
                            child: Text('Calcular Carta'),
                            color: Colors.deepPurple,
                            textColor: Colors.white,
                            onPressed: () => _calcularCarta(_fecha, _nombre),
                          ),
                        ),
                        Divider(),
                      ],
                    ))));
  }

  Widget _crearPersona() {
    return TextFormField(
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 15, color: Colors.deepPurple),
      //initialValue: carta.nombre,
      autofocus: false,
      //controller: _nombreEditingController,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => carta.nombre = value,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Nombre de la persona',
          hintStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.deepPurple[100]),
          labelText: 'Nombres y Apellidos',
          labelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.deepPurple[100]),
          helperText: 'como se indica en el documento',
          helperStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.deepPurple[400]),
          suffixIcon: Icon(Icons.wc),
          icon: Icon(Icons.account_circle)),
      onChanged: (valor) {
        setState(() {
          _nombre = valor;
        });
      },
    );
  }

  Widget _crearFecha(BuildContext context) {
    return TextFormField(
      //initialValue: carta.fechaNacimiento,
      enableInteractiveSelection: true,
      cursorColor: Colors.deepPurple[200],
      controller: _fechaEditingController,
      onSaved: (value) => carta.fechaNacimiento = value,
      decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
          hintText: 'Fecha de Nacimiento',
          hintStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.deepPurple[100]),
          labelText: 'ej: 02/10/1973',
          labelStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.deepPurple[100]),
          helperText: 'como se indica en el documento',
          helperStyle: TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 12,
              color: Colors.deepPurple[400]),
          suffixIcon: Icon(Icons.calendar_today),
          icon: Icon(Icons.date_range)),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate(context);
      },
    );
  }

  _selectDate(BuildContext context) async {
    DateTime fechaSeleccionada = await showRoundedDatePicker(
      context: context,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      locale: Locale("es", "ES"),
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1900),
      lastDate: new DateTime(2030),
    );

    // DateTime fechaSeleccionada = await showDatePicker(
    //   context: context,
    //   locale: Locale("es", "ES"),
    //   initialDate: new DateTime.now(),
    //   firstDate: new DateTime(1900),
    //   lastDate: new DateTime(2030),
    // );
    if (fechaSeleccionada != null) {
      setState(() {
        // DateFormat formatter = DateFormat('dd-MM-yyyy');
        //_fecha = formatter.format(fechaSeleccionada);
        //print(' _fecha $_fecha');
        //_fecha = fechaSeleccionada.toString();
        // _fechaEditingController.text = _fecha;
        print('asignando fecha');
        _fechaEditingController.text = fechaSeleccionada.toString();
      });
    }
  }

  _calcularCarta(String fecha, String nombre) {
    // print(' en _calcularCarta() ');
    carta = new CartaModel();
    print(' _calcularCarta ' + ' fecha :' + fecha + ' Nombre :' + nombre);
    //var now = new DateTime.now();
    //print(DateFormat('dd/MM/yyyy').format(DateTime.parse(fecha)));
    CalculoCarta _calculo = CalculoCarta();
    carta = _calculo.calcularCarta(fecha, nombre);
    _submit();
    //mostrarSnackbar('Carta creada!!!!');
  }

  void _submit() async {
    // print(' en _submit() ');
    cartasBloc.agregarCarta(carta);

    Navigator.pop(context);
  }

  void mostrarSnackbar(String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );

    scaffoldKey.currentState.showSnackBar(snackbar);
  }
}
