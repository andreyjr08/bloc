part of 'usuario_bloc.dart';

class UsuarioState {
  final bool existeUsuario;
  final Usuario usuario;

  UsuarioState({user})
      : usuario = user,
        // ignore: unnecessary_null_comparison
        existeUsuario = (user != null) ? true : false;

  UsuarioState copyWith({ Usuario usuario}) =>
      UsuarioState(user: usuario);

  UsuarioState estadoInicial() => new UsuarioState(user: usuario);
}
