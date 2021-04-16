import 'package:estados/pages/bluetooth_print.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:estados/bloc/usuario/usuario_bloc.dart';

import 'package:estados/pages/pagina2_page.dart';
import 'package:estados/pages/pagina1_page.dart';

import 'package:estados/pages/auth.dart';
 
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => new UsuarioBloc())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: 'auth',
        routes: {
          'auth': (_) => Auth(),
          'pagina1': (_) => Pagina1Page(),
          'pagina2': (_) => Pagina2Page(),
          'bluetooth': (_) => BluetoothPrint(),
        },
      ),
    );
  }
}
