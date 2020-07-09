import 'package:numerologia001/models/carta_model.dart';
import 'package:numerologia001/providers/cartas_provider.dart';
import 'package:rxdart/rxdart.dart';

//import 'package:src/models/carta_model.dart';

class CartasBloc {
  final _cartasController = new BehaviorSubject<List<CartaModel>>();
  final _cargandoController = new BehaviorSubject<bool>();

  final _cartasProvider = new CartasProvider();

  Stream<List<CartaModel>> get cartasStream =>_cartasController.stream;
    
 

  Stream<bool> get cargando => _cargandoController.stream;

  void cargarCartas() async {
    final cartas = await _cartasProvider.cargarCartas();
    print(' en carta bloc cargar cartas ' + cartas.toString());
    _cartasController.sink.add(cartas);
    
  }

  void agregarCarta(CartaModel carta) async {
    //print(' en agregarCarta() ' + carta.toString());
    _cargandoController.sink.add(true);
    await _cartasProvider.crearCarta(carta);
    _cargandoController.sink.add(false);
  }

  void editarCarta(CartaModel carta) async {
    _cargandoController.sink.add(true);
    await _cartasProvider.editarCarta(carta);
    _cargandoController.sink.add(false);
  }

  void borrarCarta(int id) async {
    await _cartasProvider.borrarCarta(id);
  }

  dispose() {
    _cartasController?.close();
    _cargandoController?.close();
  }


}
