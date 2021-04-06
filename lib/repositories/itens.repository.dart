import 'dart:math';

import 'package:list_market/models/item.model.dart';

class ItensRepository {
  static List<Item> itens = List<Item>();

  static List<Item> carrinho = List<Item>();

  double Total = 0.0;

  var contador = 0;
  void create(Item item) {
    contador++;

    item.id = contador.toString();
    itens.add(item);
  }

  List<Item> read() {
    List<Item> encontraods = [];
    List<Item> Nencontrados = [];
    List<Item> resp = [];

    for (Item x in itens) {
      if (x.ntem == true) {
        Nencontrados.add(x);
      } else {
        encontraods.add(x);
      }
    }

    for (Item x in encontraods) {
      resp.add(x);
    }

    for (Item x in Nencontrados) {
      resp.add(x);
    }

    return resp;
  }

  void delete(String textorecebido) {
    final item = itens.singleWhere((i) => i.texto == textorecebido);
    itens.remove(item);
  }

  void edita(Item Antigo, Item Novo) {
    final item = itens.singleWhere((i) => i.texto == Antigo.texto);
    item.texto = Novo.texto;
    item.qtd = Novo.qtd;
  }

//------------- Carrinho ----------------

  void addCarrinho(Item item) {
    carrinho.add(item);
  }

  void deleteCarrinho(String textorecebido) {
    final item = carrinho.singleWhere((i) => i.texto == textorecebido);
    carrinho.remove(item);
  }

  List<Item> readCarrinho() {
    return carrinho;
  }

  total() {
    for (Item x in carrinho) {
      Total = Total + (x.qtd * x.valor);
    }
    return Total;
  }
}
