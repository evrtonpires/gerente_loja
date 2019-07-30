import 'package:flutter/material.dart';
import 'package:gerente_loja/widgets/input_field.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}
//-----------------------------------------------------------------------------
class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[850],
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Icon(
                    Icons.store_mall_directory,
                    color: Colors.pinkAccent,
                    size: 160.0,
                  ),
                  InputField(
                    icon: Icons.person_outline,
                    hint: "usuario",
                    obscure: false,
                  ),
                  InputField(
                    icon: Icons.lock_outline,
                    hint: "senha",
                    obscure: true,
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    height: 50.0,
                    child: RaisedButton(
                        color: Colors.pinkAccent,
                        child: Text("ENTRAR"),
                        textColor: Colors.white,
                        onPressed: () {}),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//-----------------------------------------------------------------------------