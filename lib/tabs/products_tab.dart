import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/widgets/category_tile.dart';

class ProductsTab extends StatefulWidget {
  @override
  _ProductsTabState createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(
        context); //deve utilizando quando usa AutomaticKeepAliveClientMixin
    return StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("products").snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
            ),
          );
        } else {
          return ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                return CategoryTile(snapshot.data.documents[index]);
              });
        }
      },
    );
  }

//-----------------------------------------------------------------------------
  //Metodo
  //funcao do AutomaticKeepAliveClientMixin para manter
  // a TAB de products viva(sem precisar ficar carregando).
  @override
  bool get wantKeepAlive => true;
}
