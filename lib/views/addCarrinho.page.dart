import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:list_market/models/item.model.dart';
import 'package:list_market/repositories/itens.repository.dart';

class AddCarrinho extends StatefulWidget {
  @override
  _AddCarrinhoState createState() => _AddCarrinhoState();
}

class _AddCarrinhoState extends State<AddCarrinho> {
  final _formKey3 = GlobalKey<FormState>();
  var _item = Item();
  final _repository = ItensRepository();

  Valor(BuildContext context) {
    if (_formKey3.currentState.validate()) {
      ItensRepository().addCarrinho(_item);
      ItensRepository().delete(_item.texto);
      _formKey3.currentState.save();
      Navigator.of(context).pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    _item = ModalRoute.of(context).settings.arguments;

    return Scaffold(
        appBar: AppBar(
          title: Text('Valor do Produto'),
          centerTitle: true,
        ),
        body: Column(children: [
          Container(
            margin: const EdgeInsets.all(16),
            child: Form(
                key: _formKey3,
                child: Column(
                  children: [
                    TextFormField(
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      textAlign: TextAlign.center,
                      initialValue: _item.qtd.toString(),
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
                      initialValue: _item.texto,
                      decoration: InputDecoration(
                          labelText: 'Produto', border: OutlineInputBorder()),
                      onSaved: (value) => _item.texto = value,
                      validator: (value) =>
                          value.isEmpty ? "Campo Obrigatório" : null,
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 16)),
                    TextFormField(
                      textAlign: TextAlign.center,
                      autofocus: true,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ],
                      decoration: InputDecoration(
                          labelText: 'Valor', border: OutlineInputBorder()),
                      onSaved: (value) => _item.valor = double.parse(value),
                      validator: (value) =>
                          double.parse(value) < 1 ? "Número acima de 1" : null,
                    ),
                  ],
                )),
          ),
          ElevatedButton.icon(
            onPressed: () => Valor(context),
            icon: Icon(Icons.shopping_basket),
            label: Text(
              'Carrinho',
              style: TextStyle(fontSize: 20),
            ),
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.green),
                padding: MaterialStateProperty.all(EdgeInsets.all(16))),
          )
        ]));
  }
}
