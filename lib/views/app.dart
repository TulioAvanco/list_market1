import 'package:flutter/material.dart';
import 'package:list_market/views/addCarrinho.page.dart';
import 'package:list_market/views/carrinho.page.dart';
import 'package:list_market/views/listar.page.dart';
import 'package:list_market/views/novo.dart';

import 'editar.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // método responsável por desenhar a tela do aplicativo.
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: ListaPage(),
      routes: {
        '/': (context) => Listar(),
        '/novo': (context) => Novo(),
        '/editar': (context) => Editar(),
        '/carrinho': (context) => Carrinho(),
        '/addCarrinho': (context) => AddCarrinho()
      },
      initialRoute: '/',
    );
  }
}
