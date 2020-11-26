import 'package:compras_app/model/struct.dart';
import 'package:compras_app/providers/shoppinglist_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ListDetail extends StatefulWidget {
  final ListaDeCompras list;
  final int index;
  ListDetail({this.list, this.index});
  @override
  State<StatefulWidget> createState() => ListDetailState();
}

class ListDetailState extends State<ListDetail> {
  TextEditingController _nombrecontroller = TextEditingController();
  TextEditingController _cantidadcontroller = TextEditingController();
  TextEditingController _preciocontroller = TextEditingController();

  void addItem() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text('Agregar producto'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      style: Theme.of(context).textTheme.subtitle2,
                      controller: _nombrecontroller,
                      autofocus: true,
                      decoration: InputDecoration(
                          labelText: 'Nombre', border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      style: Theme.of(context).textTheme.subtitle2,
                      controller: _cantidadcontroller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: 'Cantidad', border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      _nombrecontroller.clear();
                      _cantidadcontroller.clear();
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar')),
                RaisedButton(
                  child: Text('Guardar', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    final liststate =
                        Provider.of<ListaProvider>(context, listen: false);
                    liststate.agregarProducto(
                        widget.index,
                        _nombrecontroller.text,
                        int.tryParse(_cantidadcontroller.text));
                    _nombrecontroller.clear();
                    _cantidadcontroller.clear();
                    Navigator.pop(context);
                  },
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                )
              ],
            ));
  }

  void itemDetail(int itemindex) {
    final lista = Provider.of<ListaProvider>(context, listen: false);
    final item = lista.mislistas[widget.index].productos[itemindex];
    _cantidadcontroller.text = item.cantidad.toString();
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text(item.nombre),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: _cantidadcontroller,
                      keyboardType: TextInputType.number,
                      style: Theme.of(context).textTheme.subtitle2,
                      decoration: InputDecoration(
                          labelText: 'Cantidad', border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      controller: _preciocontroller,
                      autofocus: true,
                      style: Theme.of(context).textTheme.subtitle2,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          prefixText: '\$',
                          labelText: 'Precio',
                          border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      _preciocontroller.clear();
                      _cantidadcontroller.clear();
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar')),
                RaisedButton(
                  child: Text('Guardar', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    lista.actualizarProducto(
                        widget.index,
                        itemindex,
                        true,
                        int.tryParse(_cantidadcontroller.text),
                        double.parse(_preciocontroller.text));
                    _preciocontroller.clear();
                    _cantidadcontroller.clear();
                    Navigator.pop(context);
                  },
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                )
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    final lista = context.watch<ListaProvider>().mislistas[widget.index];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Total: \$' + lista.total.toString()),
      ),
      body: lista.productos.length == 0
          ? Center(
              child: Text('Aún no hay productos en esta lista.'),
            )
          : ListView.builder(
              itemCount: lista.productos.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  value: lista.productos[index].comprado,
                  onChanged: (newstate) {
                    if (newstate) {
                      itemDetail(index);
                    } else {
                      final listas =
                          Provider.of<ListaProvider>(context, listen: false);
                      listas.quitarProducto(widget.index, index, newstate,
                          lista.productos[index].cantidad, 0);
                    }
                    print(lista.total.toString());
                  },
                  title: Text(
                      lista.productos[index].nombre +
                          ' x ' +
                          lista.productos[index].cantidad.toString()+"u",
                      style: TextStyle(color: Colors.black)),
                  subtitle: lista.productos[index].comprado
                      ? Text('\$' + lista.productos[index].precio.toString())
                      : null,
                );
              }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          addItem();
        },
      ),
    );
  }
}
