import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

import 'package:estados/models/usuario.dart';

import '../../models/usuario.dart';

part 'usuario_state.dart';
part 'usuario_event.dart';

class USuarioBloc extends Bloc<UsuarioEvent, UsuarioState>{


  USuarioBloc() : super(UsuarioState());



  @override
  Stream<UsuarioState> mapEventToState(UsuarioEvent event) {
    // TODO: implement mapEventToState
   print('Prueba block');
  }

}