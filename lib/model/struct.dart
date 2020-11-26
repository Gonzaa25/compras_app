class ListaDeCompras {
  int id;
  String titulo;
  String descripcion;
  List<Producto> productos = [];
  double total = 0;
  ListaDeCompras(
      {this.id, this.titulo, this.descripcion, this.productos, this.total});
}

class Producto {
  String nombre;
  int cantidad;
  double precio;
  bool comprado;
  Producto({this.nombre, this.cantidad, this.precio, this.comprado});
}
