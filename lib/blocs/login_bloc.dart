import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gerente_loja/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';

//Pagina com as Configurações do Bloc(responsavel pelo gerenciamento das telas)
class LoginBloc extends BlocBase with LoginValidators {
//-----------------------------------------------------------------------------
  //Controladores
  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();

//-----------------------------------------------------------------------------
  //Stream (tubo onde os dados saem)
  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get senhaEmail =>
      _senhaController.stream.transform(validateSenha);

//-----------------------------------------------------------------------------
  //Metodos
  @override
  void dispose() {
    _emailController.close();
    _senhaController.close();
  }
//-----------------------------------------------------------------------------
}
