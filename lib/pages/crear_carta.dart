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

//BuildContext _context 
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
        key: scaffoldKey,
        appBar: AppBar(
          title: Text("Crear carta"),
        ),
        floatingActionButton: FloatingActionButton.extended(
            label: Text('Volver'),
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_left),
            backgroundColor: Colors.deepPurple),
        body:
            // ListView(
            //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
                child: Form(
                    key: formKey,
                    child: ListView(
                      children: <Widget>[
                        _crearPersona(),
                        Divider(),
                        //_crearFecha(context),
                        //Divider(),
                        buildFecha(context),
                        buildButtonCalcularCarta(),
                        Divider(),
                      ],
                    ))));
  }

  Container buildButtonCalcularCarta() {
    return Container(
                        margin: EdgeInsets.all(20),
                        child: FlatButton(
                          child: Text('Calcular Carta'),
                          color: Colors.deepPurple,
                          textColor: Colors.white,
                          onPressed: () => _calcularCarta(_fecha, _nombre),
                        ),
                      );
  }

  Container buildFecha(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Icon(Icons.date_range),
          SizedBox(
            width: 15.0,
            //child: const Card(child: Text('Hello World!')),
          ),
          Text(
            '$_fecha',
            //icon: Icon(Icons.date_range)),
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 15,
                color: Colors.deepPurple),
          ),
          SizedBox(
            width: 20.0,
            //child: const Card(child: Text('Hello World!')),
          ),
          FlatButton(
            child: Text('Fecha de nacimiento',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Colors.deepPurple[400])),
            color: Colors.white,
            textColor: Colors.white,
            onPressed: () => _selectDate(context),
          ),
          IconButton(
            icon: Icon(Icons.calendar_today),
            tooltip: 'Seleccionar Fecha de nacimiento',
            color: Colors.deepPurple,
            onPressed: () => _selectDate(context),
          ),
        ],
      ),
    );
  }

  Widget _crearPersona() {
    return TextFormField(
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 15, color: Colors.deepPurple),
      //initialValue: carta.nombre,
      autofocus: false,
      //controller: _nombreEditingController,
      textCapitalization: TextCapitalization.sentences,
      onSaved: (value) => _nombre = value,
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

  _selectDate(BuildContext context) async {
    DateTime fechaSeleccionada = await showRoundedDatePicker(
      context: context,
      theme: ThemeData(primarySwatch: Colors.deepPurple),
      locale: Locale("es", "ES"),
      initialDate: new DateTime.now(),
      firstDate: new DateTime(1900),
      lastDate: new DateTime(2030),
    );
    if (fechaSeleccionada != null) {
      setState(() {
        _fechaEditingController.text = '02-10-1973';
        DateFormat formatter = DateFormat('dd-MM-yyyy');
        _fecha = formatter.format(fechaSeleccionada);
        print('asignando fecha' + _fecha.toString().substring(0, 10));
        _fechaEditingController.text = _fecha.toString().substring(0, 10);
      });
    }
  }

  _calcularCarta(String fecha, String nombre) {
    if (_nombre == '') {
      mostrarSnackbar(context, 'Poner el nombre de la carta numerológica');
      return;
    }
    if (_fecha == '') {
      mostrarSnackbar(
          context, 'Poner la fecha de nacimiento de la carta numerológica');
      return;
    }
    carta = new CartaModel();
    //print(' _calcularCarta ' + ' fecha :' + fecha + ' Nombre :' + nombre);
    //var now = new DateTime.now();
    //print(DateFormat('dd/MM/yyyy').format(DateTime.parse(fecha)));
    CalculoCarta _calculo = CalculoCarta();
    carta = _calculo.calcularCarta(fecha, nombre);
    _submit();
    mostrarSnackbar(context, 'Carta creada!!!!');
  }

  void _submit() async {
    // print(' en _submit() ');
    cartasBloc.agregarCarta(carta);

    Navigator.pop(context);
  }

  void mostrarSnackbar(BuildContext context, String mensaje) {
    final snackbar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    //Scaffold.of(context).showSnackBar(snackbar);
    scaffoldKey.currentState.showSnackBar(snackbar);
  }

  void _showToast(BuildContext context, String mensaje) {

      //Get.snackbar('Hi', 'i am a modern snackbar');


  }

}

// Widget _crearFecha(BuildContext context) {
  //   return TextFormField(
  //     //initialValue: carta.fechaNacimiento,
  //     //enableInteractiveSelection: true,
  //     cursorColor: Colors.deepPurple[200],
  //     controller: _fechaEditingController,
  //     //onSaved: (value) => _fecha = value,
  //     decoration: InputDecoration(
  //         border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
  //         hintText: 'Fecha de Nacimiento',
  //         hintStyle: TextStyle(
  //             fontWeight: FontWeight.normal,
  //             fontSize: 15,
  //             color: Colors.deepPurple[100]),
  //         labelText: 'ej: 02/10/1973',
  //         labelStyle: TextStyle(
  //             fontWeight: FontWeight.normal,
  //             fontSize: 15,
  //             color: Colors.deepPurple[100]),
  //         helperText: 'como se indica en el documento',
  //         helperStyle: TextStyle(
  //             fontWeight: FontWeight.normal,
  //             fontSize: 12,
  //             color: Colors.deepPurple[400]),
  //         suffixIcon: Icon(Icons.calendar_today),
  //         icon: Icon(Icons.date_range)),
  //     onTap: () {
  //       FocusScope.of(context).requestFocus(new FocusNode());
  //       _selectDate(context);
  //     },
  //   );
  // }