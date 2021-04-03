import 'package:list_market/models/item.model.dart';

class ItensRepository {
  static List<Item> itens = List<Item>();

  static List<Item> carrinho = List<Item>();

  void addCarrinho(Item item, double valor) {
    carrinho.add(item);
  }

  var contador = 0;
  void create(Item item) {
    contador++;

    item.id = contador.toString();
    itens.add(item);
  }

  List<Item> read() {
    return itens;
  }

  void delete(String textorecebido) {
    final item = itens.singleWhere((i) => i.texto == textorecebido);
    itens.remove(item);
  }
}
