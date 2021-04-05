import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_market/models/item.model.dart';
import 'package:list_market/repositories/itens.repository.dart';
import 'package:list_market/views/app.dart';

class Editar extends StatelessWidget {
  final _formKey2 = GlobalKey<FormState>();
  final _item = Item();
  final _repository = ItensRepository();
  var _itemAntigo = Item();

  Edita(BuildContext context) {
    if (_formKey2.currentState.validate()) {
      _formKey2.currentState.save();
      _repository.edita(_itemAntigo, _item);
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    _itemAntigo = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('Editar Produto'),
          centerTitle: true,
        ),
        body: Column(children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Form(
                key: _formKey2,
                child: Column(
                  children: [
                    TextFormField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      initialValue: _itemAntigo.qtd.toString(),
                      decoration: InputDecoration(
                          labelText: 'Quantidade',
                          border: OutlineInputBorder()),
                      onSaved: (value) => _item.qtd = int.parse(value),
                      validator: (value) =>
                          int.parse(value) < 1 ? "Número acima de 1" : null,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      textAlign: TextAlign.center,
                      initialValue: _itemAntigo.texto,
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
            onPressed: () => Edita(context),
            icon: Icon(Icons.edit),
            label: Text(
              'Editar',
              style: TextStyle(fontSize: 20),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.yellow[700]),
                padding: MaterialStateProperty.all(EdgeInsets.all(16))),
          )
        ]));
  }
}
