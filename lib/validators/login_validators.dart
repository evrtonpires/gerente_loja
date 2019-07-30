import 'dart:async';

class LoginValidators {
  //-----------------------------------------------------------------------------
  //StreamTransformer (objetos que transformam a Stream em outro Objeto),passandoa  entrada e a saida
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (!email.contains("@")) {
      sink.addError("Insira um email valido.");
    } else {
      sink.add(email);
    }
       /* String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
        RegExp regExp = new RegExp(pattern);
        if (email.length == 0) {
          return "Informe o Email";
        } else if(!regExp.hasMatch(email)){
          return "Email inválido";
        }else {
          return null;
        }*/
  });

  //-----------------------------------------------------------------------------
  final validateSenha =
      StreamTransformer<String, String>.fromHandlers(handleData: (senha, sink) {
    if (senha.length < 6) {
      sink.addError("Senha Invalida. Deve ser maior que 6 caracteres.");
    } else {
      sink.add(senha);
    }
  });
//-----------------------------------------------------------------------------
}
