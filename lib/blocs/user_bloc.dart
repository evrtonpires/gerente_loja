import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class UserBloc extends BlocBase {
//-----------------------------------------------------------------------------
  //Controlador
  final _userController = BehaviorSubject<List>();

//-----------------------------------------------------------------------------
//Stream
  Stream<List> get outUsers => _userController.stream;
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
        String uid = change
            .document.documentID; //ID do usuario que os dados foram modificados

        switch (change.type) {
          case DocumentChangeType.added:
            _users[uid] =
                change.document.data; //armazena os dados do usuario ao map
            _subscribeToOrders(uid);
            break;
          case DocumentChangeType.modified:
            _users[uid].addAll(
                change.document.data); //armazena as modificaçoes ao mapa
            _userController.add(_users.values.toList());
            break;
          case DocumentChangeType.removed:
            _users.remove(uid);
            _unsubscribeToOrders(uid);
            _userController.add(_users.values.toList());
            break;
        }
      });
    });
  }

  void _subscribeToOrders(String uid) {
    _users[uid]["subscription"] = _firestore
        .collection("users")
        .document(uid)
        .collection("orders")
        .snapshots()
        .listen((orders) async {
      int numOrders = orders.documents.length;

      double money = 0.0;

      for (DocumentSnapshot d in orders.documents) {
        DocumentSnapshot order =
        await _firestore.collection("orders").document(d.documentID).get();

        if (order.data == null) continue;

        money += order.data["totalPrice"];
      }

      _users[uid].addAll({"money": money, "orders": numOrders});

      _userController.add(_users.values.toList());
    });
  }

  void _unsubscribeToOrders(String uid) {
    _users[uid]["subscription"].cancel();
  }

  void onChangedSearch(String search) {
    if (search
        .trim()
        .isEmpty) {
      _userController.add(_users.values.toList());
    } else {
      _userController.add(_filter(search.trim()));
    }
  }

  //funcao de filtro
  List<Map<String, dynamic>> _filter(String search) {
    //copiando a lista de usuarios para a lista filtered
    List<Map<String, dynamic>> filteredUsers = List.from(
        _users.values.toList());

    filteredUsers.retainWhere((user) {
      return user["name"].toUpperCase().contains(search.toUpperCase());
    });
    return filteredUsers;
  }
//-----------------------------------------------------------------------------
}
