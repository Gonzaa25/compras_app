import 'package:compras_app/model/shoppingcard.dart';
import 'package:compras_app/model/struct.dart';
import 'package:compras_app/providers/page_provider.dart';
import 'package:compras_app/providers/shoppinglist_provider.dart';
import 'package:compras_app/views/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  final TextEditingController _titlecontroller = TextEditingController();
  final TextEditingController _descriptioncontroller = TextEditingController();
  final PageController _controller = PageController();

  void agregarListaDeCompras(BuildContext context) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              title: Text('Crear nueva lista de compras'),
              content: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    height: 40,
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: TextField(
                      style: Theme.of(context).textTheme.subtitle2,
                      autofocus: true,
                      controller: _titlecontroller,
                      decoration: InputDecoration(
                          labelText: 'Título', border: OutlineInputBorder()),
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
                      controller: _descriptioncontroller,
                      decoration: InputDecoration(
                          labelText: 'Descripción',
                          border: OutlineInputBorder()),
                    ),
                  ),
                ],
              ),
              actions: [
                FlatButton(
                    onPressed: () {
                      _titlecontroller.clear();
                      _descriptioncontroller.clear();
                      Navigator.pop(context);
                    },
                    child: Text('Cancelar')),
                RaisedButton(
                  child: Text('Guardar', style: TextStyle(color: Colors.white)),
                  onPressed: () {
                    final mislistas =
                        Provider.of<ListaProvider>(context, listen: false);
                    mislistas.agregarNuevaLista(ListaDeCompras(
                        id: 1,
                        titulo: _titlecontroller.text,
                        descripcion: _descriptioncontroller.text,
                        productos: [],
                        total: 0));
                    _titlecontroller.clear();
                    _descriptioncontroller.clear();
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
    final listas = context.watch<ListaProvider>();
    final pagestate = context.watch<PageProvider>();
    print('rebuild home');
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(title),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        onPageChanged: (newindex) {
          Provider.of<PageProvider>(context, listen: false)
              .updatePageIndex(newindex);
          //pagestate.updatePageIndex(newindex);
        },
        children: [
          listas.mislistas.length == 0
              ? Center(
                  child: Text(
                    'Aún no se ha creado una lista de compras.',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.center,
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => Divider(
                        thickness: 2,
                      ),
                  itemCount: listas.mislistas.length,
                  padding: EdgeInsets.all(12),
                  itemBuilder: (context, index) {
                    return ShoppingCard(
                        lista: listas.mislistas[index], index: index);
                  }),
          SettingsPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: pagestate.pageindex == 0
          ? FloatingActionButton.extended(
              backgroundColor:
                  Theme.of(context).floatingActionButtonTheme.backgroundColor,
              onPressed: () => agregarListaDeCompras(context),
              tooltip: 'Agregar',
              icon: Icon(Icons.add),
              label: Text('Crear lista'),
              elevation: 4.0,
            )
          : null,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          margin: EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              InkWell(
                onTap: () {
                  _controller
                      .animateToPage(0,
                          duration: Duration(seconds: 1), curve: Curves.easeIn)
                      .whenComplete(() =>
                          Provider.of<PageProvider>(context, listen: false)
                              .updatePageIndex(0));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.home,
                          color: pagestate.pageindex == 0
                              ? Colors.blue
                              : Colors.black),
                      Text('Inicio')
                    ],
                  ),
                ),
              ),
              SizedBox(width: 50),
              InkWell(
                onTap: () {
                  _controller
                      .animateToPage(1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.easeIn)
                      .whenComplete(() =>
                          Provider.of<PageProvider>(context, listen: false)
                              .updatePageIndex(1));
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.settings,
                          color: pagestate.pageindex == 1
                              ? Colors.blue
                              : Colors.black),
                      Text('Ajustes')
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        notchMargin: 4.0,
        color: Colors.white,
      ),
    );
  }
}
