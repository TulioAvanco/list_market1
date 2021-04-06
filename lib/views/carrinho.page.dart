import 'package:flutter/material.dart';
import 'package:list_market/models/item.model.dart';
import 'package:list_market/repositories/itens.repository.dart';

class Carrinho extends StatefulWidget {
  @override
  _CarrinhoState createState() => _CarrinhoState();
}

class _CarrinhoState extends State<Carrinho> {
  List<Item> itens;
  double Total = 0.0;

  @override
  initState() {
    super.initState();
    this.itens = ItensRepository().readCarrinho();
    Total = ItensRepository().total();
  }

  Future<bool> excluir(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (_) {
          return AlertDialog(
            title: Text("Confirma a exclusão?"),
            actions: [
              FlatButton(
                child: Text("NÃO"),
                onPressed: () => Navigator.of(context).pop(false),
              ),
              FlatButton(
                color: Colors.red,
                child: Text(
                  "SIM",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrinho'),
        actions: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Total R\$ ${Total.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 16),
              ),
              Padding(padding: EdgeInsets.only(right: 16))
            ],
          )
        ],
        centerTitle: true,
      ),
      body: itens.isEmpty
          ? Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Seu Carrinho está Vazio!',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ))
          : ListView.builder(
              itemCount: itens.length,
              itemBuilder: (_, contador) {
                var item = itens[contador];
                return Dismissible(
                  key: Key(item.texto),
                  background: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(padding: EdgeInsets.only(right: 16)),
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Padding(padding: EdgeInsets.only(right: 16)),
                        Text(
                          'Excluir',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Padding(padding: EdgeInsets.only(right: 16)),
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        )
                      ],
                    ),
                    color: Colors.red,
                  ),
                  secondaryBackground: Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Padding(padding: EdgeInsets.only(right: 16)),
                        Text(
                          'Excluir',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Padding(padding: EdgeInsets.only(right: 16)),
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                        Padding(padding: EdgeInsets.only(right: 16)),
                      ],
                    ),
                    color: Colors.red,
                  ),
                  onDismissed: (direction) {
                    ItensRepository().deleteCarrinho(item.texto);
                    setState(() => this.itens.remove(item));
                    Total = ItensRepository().total();
                  },
                  confirmDismiss: (direction) => excluir(context),
                  child: Row(
                    children: [
                      Padding(padding: EdgeInsets.only(left: 16)),
                      Padding(padding: EdgeInsets.only(top: 50)),
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(item.qtd.toString()),
                      ),
                      Padding(padding: EdgeInsets.only(right: 16)),
                      Text(
                        item.texto,
                      ),
                      Padding(padding: EdgeInsets.only(right: 16)),
                      Text('R\$'),
                      Text(item.valor.toStringAsFixed(2)),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
