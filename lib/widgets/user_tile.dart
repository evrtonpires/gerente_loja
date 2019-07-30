import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        "titulo",
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        "subtitulo",
        style: TextStyle(color: Colors.white),
      ),
      trailing: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text("Pedidos : 0", style: TextStyle(color: Colors.white)),
          Text("Gasto : 0", style: TextStyle(color: Colors.white))
        ],
      ),
    );
  }
}
