import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
//-----------------------------------------------------------------------------
//Variaveis
  final _dataController = BehaviorSubject<Map>();
  String categoryId;
  DocumentSnapshot product;

//-----------------------------------------------------------------------------
//Stream
  Stream<Map> get ouData => _dataController.stream;

//-----------------------------------------------------------------------------
//Map
  //mapa criado para nao modificar os dados direto na tela de produtos
  //para assum , salvar apenas quando clicar no botao de salvar.
  Map<String, dynamic> unsavedData;
//-----------------------------------------------------------------------------
//Construtor
  ProductBloc({this.categoryId, this.product}) {
    //copia exata do banco
    if (product != null) {
      unsavedData = Map.of(product.data);
      unsavedData["images"] = List.of(product.data["images"]);
      unsavedData["sizes"] = List.of(product.data["sizes"]);
    } else {
      unsavedData = {
        "title": null,
        "description": null,
        "price": null,
        "images": [],
        "sizes": []
      };
    }
    //sera transmitido para o _dataController e ira sair no outData
    _dataController.add(unsavedData);
  }

//-----------------------------------------------------------------------------
  // Metodo
  @override
  void dispose() {
    _dataController.close();
  }
}
