import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductBloc extends BlocBase {
//-----------------------------------------------------------------------------
//Variaveis
  String categoryId;
  DocumentSnapshot product;

//-----------------------------------------------------------------------------
//Construtor
  ProductBloc({this.categoryId, this.product}) {}

//-----------------------------------------------------------------------------
  // Metodo
  @override
  void dispose() {}
}
