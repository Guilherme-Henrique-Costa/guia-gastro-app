import 'package:flutter/material.dart';
import 'screens/tela_principal.dart';
import 'screens/tela_restaurante_detalhe.dart';

void main() {
  runApp(const GuiaGastroApp());
}

class GuiaGastroApp extends StatelessWidget {
  const GuiaGastroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Guia Gastro",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const TelaPrincipal(),
      onGenerateRoute: (settings) {
        if (settings.name == "/detalhe") {
          final id = settings.arguments as int;
          return MaterialPageRoute(
            builder: (_) => TelaRestauranteDetalhe(id: id),
          );
        }
        return null;
      },
    );
  }
}
