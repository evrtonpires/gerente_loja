import 'dart:async';

class LoginValidators {
  //-----------------------------------------------------------------------------
  //StreamTransformer (objetos que transformam a Stream em outro Objeto),passandoa  entrada e a saida
  final validateEmail =
      StreamTransformer<String, String>.fromHandlers(handleData: (email, sink) {
    if (!email.contains("@")) {
      sink.addError("Deve Conter @.");
    } else {
      sink.add(email);
    }
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
