import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:list_market/models/item.model.dart';
import 'package:list_market/repositories/itens.repository.dart';

class Listar extends StatefulWidget {
  @override
  _ListarState createState() => _ListarState();
}

class _ListarState extends State<Listar> {
  List<Item> itens;

  @override
  initState() {
    super.initState();
    this.itens = ItensRepository().read();
  }

  Future addItem(BuildContext context) async {
    var result = await Navigator.of(context).pushNamed('/novo');
    if (result == true) {
      setState(() {
        this.itens = ItensRepository().read();
      });
    }
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

  bool canEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Mercado'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: itens.length,
        itemBuilder: (_, contador) {
          var item = itens[contador];
          return Dismissible(
            key: Key(item.texto),
            background: Container(
              child: Center(
                child: Text(
                  'Excluir',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              color: Colors.red,
            ),
            secondaryBackground: Container(
              child: Center(
                child: Text(
                  'Carrinho',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              color: Colors.green,
            ),
            onDismissed: (direction) {
              if (direction == DismissDirection.endToStart) {
                ItensRepository().delete(item.texto);
                setState(() => this.itens.remove(item));
              } else if (direction == DismissDirection.startToEnd) {
                //carrinho de compra

              }
            },
            // Invoca a tela de atualizar
            // ignore: missing_return
            confirmDismiss: (direction) {
              if (direction == DismissDirection.endToStart) {
                return excluir(context);
              }
            },
            child: CheckboxListTile(
              activeColor: Colors.red,
              title: Row(
                children: [
                  canEdit
                      ? IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.yellow,
                          onPressed: () {})
                      : Padding(padding: EdgeInsets.only(top: 70)),
                  Padding(padding: EdgeInsets.only(left: 16)),
                  CircleAvatar(
                    child: Text(item.qtd.toString()),
                    backgroundColor: item.ntem ? Colors.red : Colors.green,
                  ),
                  Padding(padding: EdgeInsets.only(right: 16)),
                  Text(item.texto,
                      style: TextStyle(
                          color: item.ntem ? Colors.red : Colors.black))
                ],
              ),
              value: item.ntem,
              onChanged: (value) {
                setState(() => item.ntem = value);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_shopping_cart),
        onPressed: () => addItem(context),
      ),
    );
  }
}
