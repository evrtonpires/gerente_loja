import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:rxdart/rxdart.dart';

class ProductBloc extends BlocBase {
//-----------------------------------------------------------------------------
//Variaveis
  final _dataController = BehaviorSubject<Map>();
  final _loadingController = BehaviorSubject<bool>();
  final _createdController = BehaviorSubject<bool>();
  String categoryId;
  DocumentSnapshot product;

//-----------------------------------------------------------------------------
//Stream
  Stream<Map> get outData => _dataController.stream;

  Stream<bool> get outLoading => _loadingController.stream;

  Stream<bool> get outCreated => _createdController.stream;

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

      _createdController.add(true);
    } else {
      unsavedData = {
        "title": null,
        "description": null,
        "price": null,
        "images": [],
        "sizes": []
      };
      _createdController.add(false);
    }
    //sera transmitido para o _dataController e ira sair no outData
    _dataController.add(unsavedData);
  }

//-----------------------------------------------------------------------------
  // Metodo
  @override
  void dispose() {
    _dataController.close();
    _loadingController.close();
    _createdController.close();
  }

  void saveTitle(String title) {
    unsavedData["title"] = title;
  }

  void saveDescription(String description) {
    unsavedData["description"] = description;
  }

  void savePrice(String price) {
    unsavedData["price"] = double.parse(price);
  }

  void saveImages(List images) {
    unsavedData["images"] = images;
  }

  Future<bool> saveProduct() async {
    _loadingController.add(true);

    try {
      if (product != null) {
        //etapa de update
        await _uploadImages(product.documentID);
        await product.reference.updateData(unsavedData);
      } else {
        //etapa de criação
        DocumentReference dr = await Firestore.instance
            .collection("products")
            .document(categoryId)
            .collection("items")
            .add(Map.from(unsavedData)
          ..remove("images"));
        await _uploadImages(dr.documentID);
        await dr.updateData(unsavedData);
      }

      _createdController.add(true);
      _loadingController.add(false);
      return true;
    } catch (e) {
      _loadingController.add(false);
      return false;
    }
  }

  //pega todas as imagens que nao estao no firebase, e faz o upload no firebase
  Future _uploadImages(String productId) async {
    for (int i = 0; i < unsavedData["images"].length; i++) {
      if (unsavedData["images"][i] is String) continue;

      //salva a imagem em uma pasta chamada categoryid
      StorageUploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(categoryId)
          .child(productId)
          .child(DateTime
          .now()
          .millisecondsSinceEpoch
          .toString())
          .putFile(unsavedData["images"][i]);
      //espera o upload ser completo
      StorageTaskSnapshot s = await uploadTask.onComplete;
      //pega a url da imagem que foi pro firebase
      String downloadUrl = await s.ref.getDownloadURL();

      //pega o arquivo que estava no unsavedData, que virou uma url, e insere no produto
      unsavedData["images"][i] = downloadUrl;
    }
  }

  void deleteProduct() {
    product.reference.delete();
  }
}
