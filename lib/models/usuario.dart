import 'package:estados/bloc/usuario/usuario_bloc.dart';

class Usuario {
  final String nombre;
  final int edad;
  final List<String> profesiones;

  Usuario({this.nombre, this.edad, this.profesiones});

  Usuario copyWith({
     String nombre,
     int edad,
     List<String> profesiones,
  }) =>
      Usuario(
        nombre: nombre,
        edad: edad,
        profesiones: profesiones,
      );
}
