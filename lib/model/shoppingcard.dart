import 'package:compras_app/model/struct.dart';
import 'package:flutter/material.dart';
import 'package:compras_app/views/detail.dart';
import 'package:provider/provider.dart';
import 'package:compras_app/providers/shoppinglist_provider.dart';

class ShoppingCard extends StatelessWidget {
  final ListaDeCompras lista;
  final int index;
  ShoppingCard({this.lista, this.index});
  @override
  Widget build(BuildContext context) {
    final listas = context.watch<ListaProvider>();
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ListDetail(list: lista, index: index)));
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                    contentPadding: EdgeInsets.only(left: 5),
                    title: Text(lista.titulo,
                        style: Theme.of(context).textTheme.headline1),
                    subtitle: Text(lista.descripcion),
                    trailing: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () => showDialog(
                            context: context,
                            child: AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              content: Text('¿Desea eliminar la lista?',
                                  style: TextStyle(color: Colors.black)),
                              actions: [
                                FlatButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text('CANCELAR')),
                                RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  onPressed: () {
                                    listas.eliminarLista(index);
                                    Navigator.pop(context);
                                  },
                                  child: Text('ACEPTAR'),
                                  color: Colors.blue,
                                )
                              ],
                            )),
                        child: Text(
                          'Borrar',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                      ),
                    )),
                lista.productos
                            .where((element) => element.comprado == true)
                            .length >
                        0
                    ? Column(
                        children: [
                          Text(lista.productos
                                  .where((element) => element.comprado == true)
                                  .length
                                  .toString() +
                              '/ ${lista.productos.length}'),
                          SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: LinearProgressIndicator(
                              value: (lista.productos
                                          .where((element) =>
                                              element.comprado == true)
                                          .length *
                                      1) /
                                  lista.productos.length,
                            ),
                          ),
                          SizedBox(height: 5),
                          Text('Total a pagar: \$${lista.total.toString()}',style: TextStyle(fontSize: 17),),
                        ],
                      )
                    : Container()
              ]),
        ));
  }
}
