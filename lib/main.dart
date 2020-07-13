import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:numerologia001/pages/splash.dart';
import 'package:numerologia001/preferencias_usuario/preferencias_usuario.dart';
import 'bloc/provider.dart';
import 'routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = new PreferenciasUsuario();
    prefs.initPrefs();
    return Provider(
      child: MaterialApp(
          title: 'Numerologia 340',
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: getAplicattionRoutes(),
          theme: ThemeData(
            primaryColor: Colors.deepPurple,
            accentColor:  Colors.deepOrangeAccent,
            //colorScheme: Colors.deepPurple[400]),
          ),
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          supportedLocales: [
              const Locale('en', ''), // English, no country code
              const Locale('es', 'ES'), // Español, 
              // ... other locales the app supports
            ],
            onGenerateRoute: (RouteSettings settings) {
            return MaterialPageRoute(
                //builder: (BuildContext context) => HomePage());
                builder: (BuildContext context) => SplashScreen());
          }),
    );
  }
}
