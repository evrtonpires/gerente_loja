import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {

//-----------------------------------------------------------------------------
  //Controlador
  final _userController = BehaviorSubject();

//-----------------------------------------------------------------------------
  //Map
  Map<String, Map<String, dynamic>> _users = {};

//-----------------------------------------------------------------------------
  //Firestore para acessar o firestore mais rapido
  Firestore _firestore = Firestore.instance;

//-----------------------------------------------------------------------------
  //Construtor
  UserBloc() {
    _addUsersListener();
  }

//-----------------------------------------------------------------------------
  //Metodos
  @override
  void dispose() {
    _userController.close();
  }

  void _addUsersListener() {
    //sempre que tiver alteração no banco,ira chamar esta stream,e pode obter as modificações na colecao users
    _firestore.collection("users").snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        String uid = change.document
            .documentID; //ID do usuario que os dados foram modificados

        switch (change.type) {
          case DocumentChangeType.added:
            _users[uid] =
                change.document.data; //armazena os dados do usuario ao map

            break;
          case DocumentChangeType.modified:
            _users[uid].addAll(
                change.document.data); //armazena as modificaçoes ao mapa
            break;
          case DocumentChangeType.removed:
            _users.remove(uid);
            break;
        }
      });
    });
  }

//-----------------------------------------------------------------------------
}
