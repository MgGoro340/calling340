import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:numerologia001/bloc/provider.dart';
import 'package:numerologia001/models/carta_model.dart';
import 'package:numerologia001/pages/home_page.dart';
import 'package:numerologia001/utils/calculo_carta.dart';
import 'package:intl/intl.dart';

class CrearCartaNombre extends StatefulWidget {
  const CrearCartaNombre({Key key}) : super(key: key);

  @override
  _CrearCartaNombreState createState() => _CrearCartaNombreState();
}

class _CrearCartaNombreState extends State<CrearCartaNombre> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  double _currentPage = 0;
  final PageController _pageController = PageController();

  CartasBloc cartasBloc;
  CartaModel carta = new CartaModel();
  //bool _guardando = false;

  TextEditingController _fechaEditingController = new TextEditingController();
  //TextEditingController _nombreEditingController = new TextEditingController();
  String _fecha = '';
  String _nombre = '';
  //String _nombre = '';

  @override
  void initState() {
    _pageController.addListener(() {
      setState(() => _currentPage = _pageController.page);
    });
    super.initState();
  }

  Widget _pageViewIndicator(int location) {
    return Padding(
      padding: const EdgeInsets.only(right: 6.0, left: 6),
      child: Icon(Icons.lens,
          size: 14,
          color: location - 1 <= _currentPage && _currentPage < location
              ? Colors.deepPurple[100]
              : Colors.grey[600]),
    );
  }

//BuildContext _context
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

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
            label: Text('ir a la lista'),
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_left),
            backgroundColor: Colors.deepPurple),
        body:
            // ListView(
            //padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
            Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          color: Colors.deepPurple[400],
          child: Form(
            key: formKey,
            child: Card(
              child: Container(
                //width: size.width - 60,
                //height: 480,
                color: Colors.white,
                child: PageView(
                  controller: _pageController,
                  children: <Widget>[
                    buildListLlamarCrearPersona(),
                    buildListLlamarBuildFecha(context),
                    buildListMostrarDatosParciales(),
                  ],
                ),
              ),
              semanticContainer: true,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              elevation: 5,
              margin: EdgeInsets.all(10),
            ),
          ),

          //)
        ));
  }

  Widget buildListMostrarDatosParciales() {
    return ListView(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Datos de la Carta...',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.deepPurple)),
          ),
          //Divider(),
        ),
        Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      //color: Colors.red,
                      child: Text('Nombre',
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              fontSize: 15,
                              color: Colors.deepPurple)),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('$_nombre',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.deepPurple)),
                  ],
                ),
                Divider(),
                Row(
                  children: <Widget>[
                    Text('Fecha de Nacimiento',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.deepPurple)),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Text('$_fecha',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.deepPurple)),
                  ],
                ),
              ],
            ),
          ),
          //Divider(),
        ),
        SizedBox(
          height: 10.0,
          //child: const Card(child: Text('Hello World!')),
        ),
        llamarAnteriorPageController(),
        Divider(),
      ],
    );
  }

  Widget buildListLlamarBuildFecha(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Fecha de Nacimiento',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.deepPurple)),
          ),
          //Divider(),
        ),

        //Divider(),
        buildFecha(context),
        SizedBox(
          height: 10.0,
          //child: const Card(child: Text('Hello World!')),
        ),
        llamarSiguienteAnteriorPageController(),
        SizedBox(
          height: 10.0,
          //child: const Card(child: Text('Hello World!')),
        ),
      ],
    );
  }

  Widget buildListLlamarCrearPersona() {
    return ListView(
      children: <Widget>[
        Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text('Nombre de la persona',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    color: Colors.deepPurple)),
          ),
          //Divider(),
        ),
        SizedBox(
          height: 10.0,
          //child: const Card(child: Text('Hello World!')),
        ),
        _crearPersona(),
        SizedBox(
          height: 10.0,
          //child: const Card(child: Text('Hello World!')),
        ),
        llamarSiguientePageController(),
        Divider(),
      ],
    );
  }

  Row llamarAnteriorPageController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_left),
                tooltip: 'anterior',
                color: Colors.white,
                onPressed: () => {animateToPageAnterior()},
              ),
              Text('anterior',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.white)),
            ],
          ),
          color: Colors.deepPurple,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
            //side: BorderSide(color: Colors.red)
          ),
          onPressed: () => {animateToPageAnterior()},
        ),
        FlatButton(
          child: Row(
            children: <Widget>[
              Text('Calcular Carta...',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white)),
              IconButton(
                icon: Icon(Icons.contact_mail),
                tooltip: 'Calcular Carta...',
                color: Colors.white,
                onPressed: () => {
                  _calcularCarta(_fecha, _nombre),
                },
              ),
            ],
          ),
          color: Colors.green,
          //textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
            //side: BorderSide(color: Colors.red)
          ),
          onPressed: () => {
            _calcularCarta(_fecha, _nombre),
          },
        ),
      ],
    );
  }

  Row llamarSiguienteAnteriorPageController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        FlatButton(
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_left),
                tooltip: 'anterior',
                color: Colors.white,
                onPressed: () => {animateToPageAnterior()},
              ),
              Text('anterior',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.white)),
            ],
          ),
          color: Colors.deepPurple,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
            //side: BorderSide(color: Colors.red)
          ),
          onPressed: () => {animateToPageAnterior()},
        ),
        FlatButton(
          child: Row(
            children: <Widget>[
              Text('siguiente',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.white)),
              IconButton(
                icon: Icon(Icons.arrow_right),
                tooltip: 'siguiente',
                color: Colors.white,
                onPressed: () => {animateToPageSiguiente()},
              ),
            ],
          ),
          color: Colors.deepPurple,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
            //side: BorderSide(color: Colors.red)
          ),
          onPressed: () => {animateToPageSiguiente()},
        ),
      ],
    );
  }

  Future<void> animateToPageSiguiente() {
    return _pageController.animateToPage(_pageController.page.toInt() + 1,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  Future<void> animateToPageAnterior() {
    return _pageController.animateToPage(_pageController.page.toInt() - 1,
        duration: Duration(milliseconds: 200), curve: Curves.easeIn);
  }

  Row llamarSiguientePageController() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        FlatButton(
          child: Row(
            children: <Widget>[
              Text('siguiente',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 12,
                      color: Colors.white)),
              IconButton(
                icon: Icon(Icons.arrow_right),
                tooltip: 'siguiente',
                color: Colors.white,
                onPressed: () => {animateToPageSiguiente()},
              ),
            ],
          ),
          color: Colors.deepPurple,
          textColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40.0),
            //side: BorderSide(color: Colors.red)
          ),
          onPressed: () => {animateToPageSiguiente()},
        ),
      ],
    );
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
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              //Icon(Icons.date_range),
              SizedBox(
                width: 15.0,
                //child: const Card(child: Text('Hello World!')),
              ),
              Text(
                '$_fecha',
                //icon: Icon(Icons.date_range)),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.deepPurple),
              ),
              SizedBox(
                width: 20.0,
                //child: const Card(child: Text('Hello World!')),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              FlatButton(
                child: Text('Tocar aqui para cambiar Fecha',
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
          Divider(),
        ],
      ),
    );
  }

  Widget _crearPersona() {
    return TextFormField(
      style: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 15, color: Colors.deepPurple),
      //initialValue: carta.nombre,
      autofocus: true,
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
          //suffixIcon: Icon(Icons.wc),
          //icon: Icon(Icons.account_circle)),
          suffixIcon: Icon(Icons.account_circle)),
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
  }

  void _submit() async {
    // print(' en _submit() ');
    cartasBloc.agregarCarta(carta);
    mostrarSnackbar(context, 'Carta creada!!!!');
    // Navigator.pop(context);
    Navigator.pushNamed(context, 'verCarta', arguments: carta);
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
