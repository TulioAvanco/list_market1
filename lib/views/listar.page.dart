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
    setState(() {
      this.itens = ItensRepository().read();
    });

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

  Future<bool> carrinho(BuildContext context) async {
    return true;
  }

  bool canEdit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista Mercado'),
        centerTitle: true,
        actions: [
          Row(
            children: [
              IconButton(
                  onPressed: () => setState(() => canEdit = !canEdit),
                  icon: Icon(Icons.edit)),
              IconButton(
                  onPressed: () async {
                    var retorno = await Navigator.of(context).pushNamed(
                      '/carrinho',
                    );
                  },
                  icon: Icon(Icons.shopping_basket))
            ],
          )
        ],
      ),
      body: itens.isEmpty
          ? Container(
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Sua Lista está vazia!',
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
                    if (direction == DismissDirection.endToStart) {
                      ItensRepository().delete(item.texto);
                      setState(() => this.itens.remove(item));
                    } else if (direction == DismissDirection.startToEnd) {
                      // ignore: unnecessary_statements
                      ItensRepository().delete(item.texto);
                      setState(() => this.itens.remove(item));
                    }
                  },
                  // Invoca a tela de atualizar
                  // ignore: missing_return
                  confirmDismiss: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      return excluir(context);
                    } else if (direction == DismissDirection.startToEnd) {
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
                                color: Colors.yellow[700],
                                onPressed: () async {
                                  var retorno = await Navigator.of(context)
                                      .pushNamed('/editar', arguments: item);
                                  if (retorno != null) {
                                    setState(() =>
                                        this.itens = ItensRepository().read());
                                  }
                                })
                            : Padding(padding: EdgeInsets.only(left: 16)),
                        IconButton(
                            icon: Icon(Icons.shopping_basket),
                            color: Colors.green,
                            onPressed: () async {
                              var retorno = await Navigator.of(context)
                                  .pushNamed('/addCarrinho', arguments: item);
                              if (retorno != null) {
                                setState(() =>
                                    this.itens = ItensRepository().read());
                              }
                            }),
                        Padding(padding: EdgeInsets.only(left: 16)),
                        CircleAvatar(
                          child: Text(item.qtd.toString()),
                          backgroundColor: item.ntem ? Colors.red : Colors.blue,
                        ),
                        Padding(padding: EdgeInsets.only(right: 16)),
                        Text(item.texto,
                            style: TextStyle(
                                color: item.ntem ? Colors.red : Colors.black))
                      ],
                    ),
                    value: item.ntem,
                    onChanged: (value) {
                      setState(() {
                        item.ntem = value;
                        this.itens = ItensRepository().read();
                      });
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.post_add),
        onPressed: () => addItem(context),
      ),
    );
  }
}
