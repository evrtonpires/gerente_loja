import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/widgets/order_header.dart';

class OrderTile extends StatelessWidget {
//-----------------------------------------------------------------------------
//Atributos
  final DocumentSnapshot order;

  final states = [
    "", "Em Preparação", "Em Transporte", "Aguardando Entrega", "Entregue"
  ];

//-----------------------------------------------------------------------------
//Construtor
  OrderTile(this.order);

//-----------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(
            "#${order.documentID.substring(
                order.documentID.length - 15, order.documentID.length)} - "
                "${states[order.data["status"]]}",
            style: TextStyle(
                color: order.data["status"] != 4 ? Colors.grey[850] : Colors
                    .green),
          ),
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  OrderHeader(),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: order.data["products"].map<Widget>((produto) {
                      return ListTile(
                        title: Text(produto["product"]["title"] + " - " +
                            produto["size"]),
                        subtitle: Text(
                            produto["category"] + " / " + produto["pid"]),
                        trailing: Text(
                          produto["quantity"].toString(),
                          style: TextStyle(fontSize: 20),
                        ),
                        contentPadding: EdgeInsets.zero,
                      );
                    }
                    ).toList(),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      FlatButton(
                          onPressed: () {},
                          textColor: Colors.red,
                          child: Text("Excluir")),
                      FlatButton(
                          onPressed: () {},
                          textColor: Colors.grey[850],
                          child: Text("Regredir")),
                      FlatButton(
                          onPressed: () {},
                          textColor: Colors.green,
                          child: Text("Avançar")),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
