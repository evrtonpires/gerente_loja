import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class OrdersBloc extends BlocBase {
//-----------------------------------------------------------------------------
//Controlador
  final _ordersController = BehaviorSubject<List>();

//-----------------------------------------------------------------------------
//Lista de Pedidos
  List<DocumentSnapshot> _orders = [];

//-----------------------------------------------------------------------------
//Firestore
  Firestore _firestore = Firestore.instance;

//-----------------------------------------------------------------------------
//Stream
  Stream<List> get outOrders => _ordersController.stream;

//-----------------------------------------------------------------------------
//Contrutor
  OrdersBloc() {
    _addOrdersListener();
  }

//-----------------------------------------------------------------------------
//Metodos

  @override
  void dispose() {
    _ordersController.close();
  }

  //Funcao onde sempre que excluir , modificar ou adicionar, vira em tempo instantaneo
  void _addOrdersListener() {
    _firestore.collection("orders").snapshots().listen((snapshot) {
      snapshot.documentChanges.forEach((change) {
        String oid = change.document.documentID;

        switch (change.type) {
          case DocumentChangeType.added:
            _orders.add(change.document);
            break;
          case DocumentChangeType.modified:
            _orders.removeWhere((order) => order.documentID == oid);
            _orders.add(change.document);
            break;
          case DocumentChangeType.removed:
            _orders.removeWhere((order) => order.documentID == oid);
            break;
        }
      });

      _ordersController.add(_orders);
    });
  }
//-----------------------------------------------------------------------------
}
