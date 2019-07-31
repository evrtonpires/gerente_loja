import 'package:flutter/material.dart';
import 'package:gerente_loja/widgets/order_header.dart';

class OrderTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Card(
        child: ExpansionTile(
          title: Text(
            "#132165489 - Entregue",
            style: TextStyle(color: Colors.green),
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
                    children: <Widget>[
                      ListTile(
                        title: Text("camiseta preta P"),
                        subtitle: Text("camisetas / asas kajslk"),
                        trailing: Text(
                          "2",
                          style: TextStyle(fontSize: 20),
                        ),
                        contentPadding: EdgeInsets.zero,
                      ),
                    ],
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
