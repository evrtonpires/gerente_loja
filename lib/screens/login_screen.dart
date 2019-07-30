import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/login_bloc.dart';
import 'package:gerente_loja/widgets/input_field.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

//-----------------------------------------------------------------------------
class _LoginScreenState extends State<LoginScreen> {
  final _loginBloc = LoginBloc();

  @override
  void initState() {
    super.initState();

    _loginBloc.outState.listen((state){
      switch(state){
        case LoginState.SUCCESS:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomeScreen())
          );
          break;

        case LoginState.FAIL:
          showDialog(context: context, builder: (context) => AlertDialog(
            title: Text("Erro"),
            content: Text("Voce não possui os privilegios necessários."),
          ) );
          break;

        case LoginState.LOADING:
        case LoginState.IDLE:
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[850],
        body: StreamBuilder<LoginState>(
            stream: _loginBloc.outState,
            initialData: LoginState.LOADING,
            builder: (context, snapshot) {
              switch (snapshot.data) {
                case LoginState.LOADING:
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(Colors.pinkAccent),
                    ),
                  );


                case LoginState.FAIL:
                case LoginState.SUCCESS:
                case LoginState.IDLE:
                return Stack(
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
                                stream: _loginBloc.outEmail,
                                onChanged: _loginBloc.changeEmail,
                              ),
                              InputField(
                                icon: Icons.lock_outline,
                                hint: "senha",
                                obscure: true,
                                stream: _loginBloc.outSenha,
                                onChanged: _loginBloc.changeSenha,
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              StreamBuilder<bool>(
                                stream: _loginBloc.outSubmitValid,
                                builder: (context, snapshot) {
                                  return SizedBox(
                                    height: 50.0,
                                    child: RaisedButton(
                                        color: Colors.pinkAccent,
                                        child: Text("ENTRAR"),
                                        textColor: Colors.white,
                                        disabledTextColor:
                                            Colors.white.withAlpha(70),
                                        disabledColor:
                                            Colors.pinkAccent.withAlpha(70),
                                        onPressed: snapshot.hasData
                                            ? _loginBloc.submit
                                            : null),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
              }
            })
    );
  }
}
//-----------------------------------------------------------------------------
