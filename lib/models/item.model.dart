class Item {
  String id;
  String texto;
  int qtd;
  double valor;
  int status;
  bool ntem;

  Item(
      {this.id,
      this.texto,
      this.qtd = 1,
      this.valor = 0.00,
      this.status = 0,
      this.ntem = false});
}
