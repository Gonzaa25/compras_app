import 'package:flutter/material.dart';
import 'package:compras_app/model/struct.dart';

class ListaProvider extends ChangeNotifier {
  Producto producto;
  List<ListaDeCompras> _mislistas = [];
  List<ListaDeCompras> get mislistas => _mislistas;

  //Recibe una nueva listadecompras para ser agregada a la lista principal.
  void agregarNuevaLista(ListaDeCompras lista) {
    _mislistas.add(lista);
    notifyListeners();
  }

  //Recibe la posición de la listadecompras a eliminar dentro de la lista princial.
  void eliminarLista(int index) {
    _mislistas.removeAt(index);
    notifyListeners();
  }

  //Ubica la lista de compras que se esta utilizando y agrega un producto a dicha lista con precio default cero.
  void agregarProducto(int index, String nombre, int cantidad) {
    _mislistas[index].productos.add(Producto(
        nombre: nombre, cantidad: cantidad, precio: 0, comprado: false));
    notifyListeners();
  }

  void actualizarProducto(
      int index, int itemindex, bool comprado, int cantidad, double precio) {
    producto = _mislistas[index].productos[itemindex];
    producto.comprado = comprado;
    producto.cantidad = cantidad;
    producto.precio = precio;
    _mislistas[index].total += producto.precio * producto.cantidad;
    notifyListeners();
  }

  void quitarProducto(
      int index, int itemindex, bool comprado, int cantidad, double precio) {
    producto = _mislistas[index].productos[itemindex];
    producto.comprado = comprado;
    _mislistas[index].total -= producto.precio * producto.cantidad;
    producto.cantidad = cantidad;
    producto.precio = precio;
    notifyListeners();
  }
}
