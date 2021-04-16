import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'dart:async';

class Auth extends StatefulWidget {
  @override
  _AuthState createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  //bool _canCheckBiometrics;
  List<BiometricType> _availableBiometrics;
  String _authorized = 'No Autorizado';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    auth.isDeviceSupported().then(
          (isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  /*Future<void> _checkBiometrics() async {
    //late bool _canCheckBiometrics;
    try {
      _canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      _canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = _canCheckBiometrics;
    });
  }*/

  /*Future<void> _getAvailableBiometrics() async {
    //late List<BiometricType> availableBiometrics;
    try {
      _availableBiometrics = await auth.getAvailableBiometrics();
      _availableBiometrics.contains(BiometricType.face);
    } on PlatformException catch (e) {
      _availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = _availableBiometrics;
    });
  }*/

  /*Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    setState(
        () => _authorized = authenticated ? 'Authorized' : 'Not Authorized');
  }*/

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Autenticando';
      });
      authenticated = await auth.authenticate(
          localizedReason: 'Para continuar debe autenticarse con huella',
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Autenticando';
      });

    } on PlatformException catch (e) {
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    final String message = authenticated ? 'Autorizado' : 'No Autorizado';
    setState(() {
      _authorized = message;
    });
    if (authenticated) {
      Navigator.pushNamed(context, 'pagina1');
    }
  }

  void _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: ListView(
          padding: const EdgeInsets.only(top: 30),
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_supportState == _SupportState.unknown)
                  CircularProgressIndicator()
                else if (_supportState == _SupportState.supported)
                  Text("Este dispositivo soporta huella")
                else
                  Text("Este dispositivo soporta huella"),
                Divider(height: 100),
                Text('Estado: $_authorized\n'),
                (_isAuthenticating)
                    ? ElevatedButton(
                        onPressed: _cancelAuthentication,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text("Cancelar"),
                            Icon(Icons.cancel),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          ElevatedButton(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(_isAuthenticating ? 'Cancelar' : 'Huella'),
                                Icon(Icons.fingerprint),
                              ],
                            ),
                            onPressed: _authenticateWithBiometrics,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                           Text('Prueba Impresion'),
                          ElevatedButton(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.print),
                              ],
                            ),
                           onPressed: () => Navigator.pushNamed(context, 'bluetooth')
                          ),
                        ],
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
