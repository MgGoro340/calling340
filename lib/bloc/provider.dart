import 'package:flutter/material.dart';
import 'package:numerologia001/bloc/carta_bloc.dart';
export 'package:numerologia001/bloc/carta_bloc.dart';

class Provider extends InheritedWidget {
  final _cartasBloc = new CartasBloc();
  static Provider _instancia;

  factory Provider({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new Provider._internal(key: key, child: child);
    }

    return _instancia;
  }

  Provider._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static CartasBloc cartasBloc(BuildContext context) {
    print(' en cartas bloc del provider');
    return context.dependOnInheritedWidgetOfExactType<Provider>()._cartasBloc;
    // ignore: deprecated_member_use
    //return (context.inheritFromWidgetOfExactType(Provider) as Provider)._cartasBloc;
  }
}
