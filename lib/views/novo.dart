import 'package:flutter/material.dart';
import 'package:list_market/models/item.model.dart';
import 'package:list_market/repositories/itens.repository.dart';
import 'package:list_market/views/app.dart';

class Novo extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _item = Item();
  final _repository = ItensRepository();

  salvar(BuildContext context) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _repository.create(_item);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Novo Item'),
          centerTitle: true,
        ),
        body: Column(children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: 'Quantidade',
                          border: OutlineInputBorder()),
                      onSaved: (value) => _item.qtd = int.parse(value),
                      validator: (value) =>
                          int.parse(value) < 1 ? "Número acima de 1" : null,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      decoration: InputDecoration(
                          labelText: 'Produto', border: OutlineInputBorder()),
                      onSaved: (value) => _item.texto = value,
                      validator: (value) =>
                          value.isEmpty ? "Campo Obrigatório" : null,
                    ),
                  ],
                )),
          ),
          ElevatedButton.icon(
            onPressed: () => salvar(context),
            icon: Icon(Icons.add),
            label: Text(
              'Adicionar',
              style: TextStyle(fontSize: 20),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                padding: MaterialStateProperty.all(EdgeInsets.all(16))),
          )
        ]));
  }
}
