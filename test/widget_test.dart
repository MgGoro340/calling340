import 'package:flutter_test/flutter_test.dart';
import 'package:numerologia001/models/carta_model.dart';
import 'package:numerologia001/utils/calculo_carta.dart';

void main() {


  testWidgets('Calculo de la carta Martin ', (WidgetTester tester) async {
    CartaModel carta = new CartaModel();

    CalculoCarta _calculo = CalculoCarta();
    carta = _calculo.calcularCarta('02-10-1973', 'Martin Gustavo Goró');
    expect('2', carta.nacimiento);
    expect('5', carta.caminoVida);
    expect('5', carta.caminoAlma);
    expect('5', carta.personalidad);
    expect('1', carta.temperamento);
    expect('5', carta.mision);
    expect('6', carta.metaFinal);
    expect('5', carta.sumatoriaConsonante);
    expect('5', carta.sumatoriaVocal);
  });

  testWidgets('Calculo de la carta Laura ', (WidgetTester tester) async {
    CartaModel carta = new CartaModel();

    CalculoCarta _calculo = CalculoCarta();
    carta = _calculo.calcularCarta('11-03-1977', 'Maria Laura Udria');
    expect('2', carta.nacimiento);
    expect('2', carta.caminoVida);
    expect('2', carta.caminoAlma);
    expect('2', carta.personalidad);
    expect('4', carta.temperamento);
    expect('3', carta.mision);
    expect('6', carta.metaFinal);
    expect('2', carta.sumatoriaConsonante);
    expect('2', carta.sumatoriaVocal);
  });

  testWidgets('Calculo de la carta Anabella ', (WidgetTester tester) async {
    CartaModel carta = new CartaModel();

    CalculoCarta _calculo = CalculoCarta();
    carta = _calculo.calcularCarta('02-03-1981', 'Anabella Elizabeth Santini');
    expect('2', carta.nacimiento);
    expect('6', carta.caminoVida);
    expect('2', carta.caminoAlma);
    expect('4', carta.personalidad);
    expect('6', carta.temperamento);
    expect('4', carta.mision);
    expect('3', carta.metaFinal);
    expect('4', carta.sumatoriaConsonante);
    expect('2', carta.sumatoriaVocal);
  });



  testWidgets('Calculo de la cartaLaura veronica schiavoni',
      (WidgetTester tester) async {
    CartaModel carta = new CartaModel();

    CalculoCarta _calculo = CalculoCarta();
    carta = _calculo.calcularCarta('23-09-1974', 'Laura veronica schiavoni');
    expect('5', carta.nacimiento);
    expect('8', carta.caminoVida);
    expect('6', carta.caminoAlma);
    expect('9', carta.personalidad);
    expect('6', carta.temperamento);
    expect('7', carta.mision);
    expect('5', carta.metaFinal);
    expect('9', carta.sumatoriaConsonante);
    expect('6', carta.sumatoriaVocal);
  });

  testWidgets('Calculo de la carta Mariano Rivero ',
      (WidgetTester tester) async {
    CartaModel carta = new CartaModel();

    CalculoCarta _calculo = CalculoCarta();
    carta = _calculo.calcularCarta('13-02-1993', 'Mariano Daniel Rivero');
    expect('4', carta.nacimiento);
    expect('1', carta.caminoVida);
    expect('7', carta.caminoAlma);
    expect('7', carta.personalidad);
    expect('5', carta.temperamento);
    expect('9', carta.mision);
    expect('6', carta.metaFinal);
    expect('7', carta.sumatoriaConsonante);
    expect('7', carta.sumatoriaVocal);
  });



  testWidgets('Calculo de la carta jopi ',
      (WidgetTester tester) async {
    CartaModel carta = new CartaModel();

    CalculoCarta _calculo = CalculoCarta();
    carta = _calculo.calcularCarta('17-02-1994', 'Jose Mario Apestey Abregu');
    expect('8', carta.nacimiento);
    expect('6', carta.caminoVida);
    expect('9', carta.caminoAlma);
    expect('7', carta.personalidad);
    expect('7', carta.temperamento);
    expect('4', carta.mision);
    expect('4', carta.metaFinal);
    expect('7', carta.sumatoriaConsonante);
    expect('9', carta.sumatoriaVocal);
  });




}
