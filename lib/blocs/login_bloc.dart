import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:gerente_loja/validators/login_validators.dart';
import 'package:rxdart/rxdart.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Pagina com as Configurações do Bloc(responsavel pelo gerenciamento das telas)

enum LoginState{IDLE, LOADING, SUCCESS, FAIL}

//-----------------------------------------------------------------------------
class LoginBloc extends BlocBase with LoginValidators {
//-----------------------------------------------------------------------------
  //Construtor
  LoginBloc(){
    FirebaseAuth.instance.onAuthStateChanged.listen((usuario){
      if(usuario != null){

      }else{
        _stateController.add(LoginState.IDLE);
      }
    });
  }

//-----------------------------------------------------------------------------
  //Controladores
  final _emailController = BehaviorSubject<String>();
  final _senhaController = BehaviorSubject<String>();

  //CONTROLADOR DE ESTADO DO LOGIN
  final _stateController = BehaviorSubject<LoginState>();

//-----------------------------------------------------------------------------
  //Stream (tubo onde os dados saem)
  Stream<String> get outEmail =>
      _emailController.stream.transform(validateEmail);

  Stream<String> get outSenha =>
      _senhaController.stream.transform(validateSenha);

  Stream<bool> get outSubmitValid => Observable.combineLatest2(
      outEmail, outSenha, (a,b) => true
  );

  Stream<LoginState> get outState => _stateController.stream;

//-----------------------------------------------------------------------------
  //Metodos
  @override
  void dispose() {
    _emailController.close();
    _senhaController.close();
    _stateController.close();
  }

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changeSenha => _senhaController.sink.add;

  void submit(){
    //obtendo o ultimo dado da Stream para pegar seus valores
    final email = _emailController.value;
    final senha = _senhaController.value;

    _stateController.add(LoginState.LOADING);

    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email, password: senha)
        .catchError((e){
          _stateController.add(LoginState.FAIL);
    });
  }

//-----------------------------------------------------------------------------
}
