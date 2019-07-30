import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/user_bloc.dart';
import 'package:gerente_loja/tabs/users_tab.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
//-----------------------------------------------------------------------------
//Controlador
  PageController _pageController;

//-----------------------------------------------------------------------------
//Variavel
  int _paginaClicada = 0;

//-----------------------------------------------------------------------------
//UserBloc
  UserBloc _userBloc;

//-----------------------------------------------------------------------------
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _userBloc = UserBloc();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

//-----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[850],
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
              canvasColor: Colors.pinkAccent, //cor de fundo
              primaryColor: Colors.white, //cor do icone
              textTheme: Theme
                  .of(context)
                  .textTheme
                  .copyWith(caption: TextStyle(color: Colors.white54))),
          child: BottomNavigationBar(
              currentIndex: _paginaClicada,
              onTap: (paginaClicada) {
                _pageController.animateToPage(paginaClicada,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeOutBack);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  title: Text("Clientes"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart),
                  title: Text("Pedidos"),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.list),
                  title: Text("Produtos"),
                ),
              ]),
        ),

        //definindo a pageView para ter telas de rolagem
        body: SafeArea(
            child: BlocProvider<UserBloc>(
              bloc: _userBloc,
              child: PageView(
                controller: _pageController,
                onPageChanged: (paginaClicada) {
                  setState(() {
                    _paginaClicada = paginaClicada;
                  });
                },
                children: <Widget>[
                  UsersTab(),
                  Container(
                    color: Colors.yellow,
                  ),
                  Container(
                    color: Colors.green,
                  ),
                ],
              ),
            )));
  }
}
