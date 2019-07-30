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

  Stream<String> get outSenha =>
      _senhaController.stream.transform(validateSenha);

  Stream<bool> get outSubmitValid => Observable.combineLatest2(
      outEmail, outSenha, (a,b) => true
  );

//-----------------------------------------------------------------------------
  //Metodos
  @override
  void dispose() {
    _emailController.close();
    _senhaController.close();
  }

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeSenha => _senhaController.sink.add;
//-----------------------------------------------------------------------------
}
