import 'package:numerologia001/models/carta_model.dart';

class CalculoCarta {
  List<String> tablaAlfabetica = new List<String>();
  List<String> tablaNumerica = new List<String>();

  //CartaModel _cartaCalculada = new CartaModel();

  CalculoCarta();

  // forma de calculo:
  // nacimiento = dia de nacimiento reducido.. si nacio un 11 es 2 si nacio un 27 es 9
  //sumatoria de consonantes es la suma de todas las consonantes de los nnombres
  //sumatoria de vocal es la suma de todas las vocales del nombre
  //camino o sendero de vida es la suma de la fecha de nacimiento
  //camino del alma es la sumatoriade las vocales
  // personalidad es la suma de las consonantes
  // temperamento es la suma camino del alma y personalidad reducidos
  //mision es la suma de las iniciales mas el camino de vida
  //meta final es la suma  de temperamento  mas camino de vida, siempre reducido

  CartaModel calcularCarta(String fechaNacimiento, String nombre) {
    CartaModel _cartaCalculada = new CartaModel();

    _cartaCalculada.nombre = nombre;
    _cartaCalculada.fechaNacimiento = fechaNacimiento;
    _cartaCalculada.sumatoriaConsonante = _calcularSumatoriaConsonantes(nombre);
    _cartaCalculada.nacimiento = _calcularDiaNacimiento(fechaNacimiento);
    _cartaCalculada.sumatoriaVocal = _calcularSumatoriaVocales(nombre);
    _cartaCalculada.caminoVida = _calcularNacimiento(fechaNacimiento);
    _cartaCalculada.caminoAlma = _cartaCalculada.sumatoriaVocal;
    _cartaCalculada.personalidad = _cartaCalculada.sumatoriaConsonante;
    _cartaCalculada.temperamento = _calcularEntidad(
        _cartaCalculada.caminoAlma, _cartaCalculada.personalidad);
    _cartaCalculada.mision = _calcularEntidad(
        _calcularSumatoriaIniciales(nombre), _cartaCalculada.caminoVida);
    _cartaCalculada.metaFinal = _calcularEntidad(
        _cartaCalculada.temperamento, _cartaCalculada.caminoVida);

    return _cartaCalculada;
  }

  /**
  * 
  * se toma la fecha de nacimiento por ejemplo 02/10/1973
  * y se suman todos los numeros
  * 0+2+1+0+1+9+7+3 = 23, este resultado se toma como caracter y se suma
  * 23 = 2 + 3  = 5
  */
  // void main() {
  // print(_calcularNacimiento('02/10/1973'));//5
  // print(_calcularNacimiento('31/09/1999'));//5
  // print(_calcularNacimiento('07/09/2003'));//3
  // print(_calcularNacimiento('28/04/2006'));//4
  // print(_calcularNacimiento('16/06/2010'));//7
  // print(_calcularNacimiento('11/03/2003'));//1
  //print(_calcularSumatoriaConsonantes('Martín Gustavo Goró'));
  //print(_calcularSumatoriaConsonantes('Santiago Martín Goró'));
  //print(_calcularSumatoriaConsonantes('Sofía Aylén Goró'));
  //print(_calcularSumatoriaConsonantes('Ignacio Nahuel Goró'));
  //print(_calcularSumatoriaConsonantes('Maria Laura Udria'));

  //print(_calcularSumatoriaVocales('Martín Gustavo Goró'));
  //print(_calcularSumatoriaVocales('Santiago Martín Goró'));
  //print(_calcularSumatoriaVocales('Sofía Aylén Goró'));
  //print(_calcularSumatoriaVocales('Ignacio Nahuel Goró'));
  //print(_calcularSumatoriaVocales('Maria Laura Udria'));

  // print(_calcularSumatoriaIniciales('Martín Gustavo Goró'));
  // print(_calcularSumatoriaIniciales('Santiago Martín Goró'));
  // print(_calcularSumatoriaIniciales('Sofía Aylén Goró'));
  // print(_calcularSumatoriaIniciales('Ignacio Nahuel Goró'));
  // print(_calcularSumatoriaIniciales('Maria Laura Udria'));

  //  print(_calcularDiaNacimiento('02/10/1973'));//2
  //  print(_calcularDiaNacimiento('31/09/1999'));//4
  //  print(_calcularDiaNacimiento('07/09/2003'));//7
  //  print(_calcularDiaNacimiento('28/04/2006'));//1
  //  print(_calcularDiaNacimiento('16/06/2010'));//7
  //  print(_calcularDiaNacimiento('11/03/2003'));//2

  // }

  String _calcularEntidad(String caminoAlma, String personalidad) {
    //var temperamento = '';
    var tmp = 0;

    tmp = int.parse(caminoAlma) + int.parse(personalidad);

    while (tmp.toString().length > 1) {
      tmp = _reducir(tmp.toString());
    }
    return (tmp.toString());
  }

  String _calcularSumatoriaIniciales(String nombre) {
    var nombreTmp = nombre.toLowerCase();
    var index = '';
    var indexSiguiente = '';
    int tmp = 0;

    tmp = tmp +
        int.parse(_obtenerNumeroDesdeLetra(
            nombreTmp.substring(0, 1))); // la primer Inicial
    print('Inicial : ' + nombreTmp.substring(0, 1) + ' - ' + tmp.toString());

    for (var i = 0; i < nombreTmp.length; i++) {
      index = nombreTmp.substring(i, i + 1);
      if (i < nombreTmp.length - 1) {
        indexSiguiente = nombreTmp.substring(i + 1, i + 1 + 1);
        if (index == ' ' && indexSiguiente != ' ') {
          print('Inicial : ' +
              nombreTmp.substring(i + 1, i + 1 + 1) +
              ' - ' +
              _obtenerNumeroDesdeLetra(indexSiguiente));
          tmp = tmp + int.parse(_obtenerNumeroDesdeLetra(indexSiguiente));
        }
      }
    }
    while (tmp.toString().length > 1) {
      tmp = _reducir(tmp.toString());
    }
    return (tmp.toString());
  }

  String _calcularDiaNacimiento(fechaNacimiento) {
    //String tmp = '';
    int tmp = 0;
    tmp = int.parse(fechaNacimiento.substring(0, 1)) +
        int.parse(fechaNacimiento.substring(1, 2));

    while (tmp.toString().length > 1) {
      tmp = _reducir(tmp.toString());
    }

    return (tmp.toString());
  }

  String _calcularSumatoriaConsonantes(String nombre) {
    var nombreTmp = nombre.toLowerCase();
    var index = '';
    int tmp = 0;
    for (var i = 0; i < nombreTmp.length; i++) {
      index = nombreTmp.substring(i, i + 1);
      if (index != ' ' && _esConsonanteDesdeLetra(index)) {
        //print(index  + ' - ' + obtenerNumeroDesdeLetra(index) );
        tmp = tmp + int.parse(_obtenerNumeroDesdeLetra(index));
      }
    }
    while (tmp.toString().length > 1) {
      tmp = _reducir(tmp.toString());
    }
    return (tmp.toString());
  }

  String _calcularSumatoriaVocales(String nombre) {
    var nombreTmp = nombre.toLowerCase();
    var index = '';
    int tmp = 0;
    for (var i = 0; i < nombreTmp.length; i++) {
      index = nombreTmp.substring(i, i + 1);
      if (index != "'") {
        if (index != ' ' && !_esConsonanteDesdeLetra(index)) {
          //print(index  + ' - ' + obtenerNumeroDesdeLetra(index) );
          tmp = tmp + int.parse(_obtenerNumeroDesdeLetra(index));
        }
      }
    }
    while (tmp.toString().length > 1) {
      tmp = _reducir(tmp.toString());
    }
    return (tmp.toString());
  }

  String _calcularNacimiento(fechaNacimiento) {
    //String tmp = '';
    int tmp = 0;
    tmp = int.parse(fechaNacimiento.substring(0, 1)) +
        int.parse(fechaNacimiento.substring(1, 2)) +
        int.parse(fechaNacimiento.substring(3, 4)) +
        int.parse(fechaNacimiento.substring(4, 5)) +
        int.parse(fechaNacimiento.substring(6, 7)) +
        int.parse(fechaNacimiento.substring(7, 8)) +
        int.parse(fechaNacimiento.substring(8, 9)) +
        int.parse(fechaNacimiento.substring(9, 10));

    while (tmp.toString().length > 1) {
      tmp = _reducir(tmp.toString());
    }

    return (tmp.toString());
  }

  int _reducir(String valor) {
    int tmpReducido = 0;

    tmpReducido =
        int.parse(valor.substring(0, 1)) + int.parse(valor.substring(1, 2));

    return tmpReducido;
  }

  bool _esConsonanteDesdeLetra(String letra) {
    String _vocales = 'aáäeéëiíïoóöuúüy';

    return _vocales.contains(letra) ? false : true;
  }

  String _obtenerNumeroDesdeLetra(String letra) {
    switch (letra) {
      case 'a':
        {
          return '1';
        }
        break;
      case 'á':
        {
          return '1';
        }
        break;
      case 'ä':
        {
          return '1';
        }
        break;
      case 'j':
        {
          return '1';
        }
        break;
      case 's':
        {
          return '1';
        }
        break;
      case 'b':
        {
          return '2';
        }
        break;
      case 'k':
        {
          return '2';
        }
        break;
      case 't':
        {
          return '2';
        }
        break;
      case 'c':
        {
          return '3';
        }
        break;
      case 'Ç':
        {
          return '3';
        }
        break;
      case 'l':
        {
          return '3';
        }
        break;
      case 'u':
        {
          return '3';
        }
        break;
      case 'ú':
        {
          return '3';
        }
        break;
      case 'ü':
        {
          return '3';
        }
        break;
      case 'd':
        {
          return '4';
        }
        break;
      case 'm':
        {
          return '4';
        }
        break;
      case 'v':
        {
          return '4';
        }
        break;
      case 'e':
        {
          return '5';
        }
        break;
      case 'é':
        {
          return '5';
        }
        break;
      case 'ë':
        {
          return '5';
        }
        break;
      case 'n':
        {
          return '5';
        }
        break;
      case 'ñ':
        {
          return '5';
        }
        break;
      case 'w':
        {
          return '5';
        }
        break;
      case 'f':
        {
          return '6';
        }
        break;
      case 'o':
        {
          return '6';
        }
        break;
      case 'ó':
        {
          return '6';
        }
        break;
      case 'ö':
        {
          return '6';
        }
        break;
      case 'x':
        {
          return '6';
        }
        break;
      case 'g':
        {
          return '7';
        }
        break;
      case 'p':
        {
          return '7';
        }
        break;
      case 'y':
        {
          return '7';
        }
        break;
      case 'h':
        {
          return '8';
        }
        break;
      case 'q':
        {
          return '8';
        }
        break;
      case 'z':
        {
          return '8';
        }
        break;
      case 'i':
        {
          return '9';
        }
        break;
      case 'í':
        {
          return '9';
        }
        break;
      case 'ï':
        {
          return '9';
        }
        break;
      case 'r':
        {
          return '9';
        }
        break;
    }
    // return '';
  }
}
