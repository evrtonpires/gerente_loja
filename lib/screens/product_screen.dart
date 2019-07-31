import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gerente_loja/blocs/product_bloc.dart';
import 'package:gerente_loja/validators/product_validator.dart';
import 'package:gerente_loja/widgets/images_widget.dart';

class ProductScreen extends StatefulWidget {
  //Tela para adicionar ou modificar Produtos
//-----------------------------------------------------------------------------
//Variaveis
  final String categoryId;
  final DocumentSnapshot product;

//-----------------------------------------------------------------------------
//Construtor
  //anotação : , se usa pois as variaveis sao "final" ,
  // para passar as variaveis no momento da construção
  ProductScreen({this.categoryId, this.product});

//-----------------------------------------------------------------------------

  @override
  _ProductScreenState createState() => _ProductScreenState(categoryId, product);
}

class _ProductScreenState extends State<ProductScreen> with ProductValidator {
//Variaveis
  final ProductBloc _productBloc;

//-----------------------------------------------------------------------------
  //Construtor
  _ProductScreenState(String categoryId, DocumentSnapshot product)
      : _productBloc = ProductBloc(categoryId: categoryId, product: product);
  final _formKey = GlobalKey<FormState>();

//-----------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final _fieldStyle = TextStyle(color: Colors.white, fontSize: 16);

    return Scaffold(
      backgroundColor: Colors.grey[850],
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        elevation: 0,
        title: Text("Criar Produto"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.remove), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _formKey.currentState.save();
                }
              }),
        ],
      ),
      body: Form(
        key: _formKey,
        child: StreamBuilder<Map>(
            stream: _productBloc.ouData,
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Container();
              return ListView(
                padding: EdgeInsets.all(16),
                children: <Widget>[
                  Text(
                    "Imagens",
                    style: TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                  ImagesWidget(
                    context: context,
                    initialValue: snapshot.data["images"],
                    onSaved: _productBloc.saveImages,
                    validator: validateImages,
                  ),
                  TextFormField(
                    initialValue: snapshot.data["title"],
                    style: _fieldStyle,
                    decoration: _buildDecoration("Titulo"),
                    onSaved: _productBloc.saveTitle,
                    validator: validateTitle,
                  ),
                  TextFormField(
                    initialValue: snapshot.data["description"],
                    style: _fieldStyle,
                    maxLines: 8,
                    decoration: _buildDecoration("Descrição"),
                    onSaved: _productBloc.saveDescription,
                    validator: validateDescription,
                  ),
                  TextFormField(
                    initialValue: snapshot.data["price"]?.toStringAsFixed(2),
                    style: _fieldStyle,
                    decoration: _buildDecoration("Preço"),
                    keyboardType:
                    TextInputType.numberWithOptions(decimal: true),
                    onSaved: _productBloc.savePrice,
                    validator: validatePrice,
                  ),
                ],
              );
            }),
      ),
    );
  }

//-----------------------------------------------------------------------------
//Funcao da Decoração
  InputDecoration _buildDecoration(String label) {
    return InputDecoration(
        labelText: label, labelStyle: TextStyle(color: Colors.grey));
  }
//-----------------------------------------------------------------------------

}
