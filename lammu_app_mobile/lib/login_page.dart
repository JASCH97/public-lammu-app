import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:lammu_app/about_app.dart';
import 'admin_page.dart';
import 'read_google_sheets.dart';
import 'professor_page.dart';

// ignore: use_key_in_widget_constructors
class LoginPage extends StatefulWidget {
  static String id = 'login_page';
  static String? fullName = _LoginPageState()._userNameController.text;
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true;
  bool isButtonPressed = false;
  // text controllers
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();

  void buttonPressed() {
    setState(() {
      if (isButtonPressed == false) {
        isButtonPressed = true;
      } else if (isButtonPressed == true) {
        isButtonPressed = false;
      }
    });
  }

  Future signIn() async {
    buttonPressed();

    if (await validate_user(
            _userNameController.text, _passwordController.text) ==
        true) {
      buttonPressed();
      if (await getRol(_userNameController.text) == true) {
        LoginPage.fullName = await getFullName(_userNameController.text);

        //se elimina la pantalla de carga
        Navigator.of(context).pop();

        final route =
            MaterialPageRoute(builder: (context) => const ProfessorPage());

        Navigator.push(context, route);
      } else {
        LoginPage.fullName = await getFullName(_userNameController.text);

        //se elimina la pantalla de carga
        Navigator.of(context).pop();

        final route =
            MaterialPageRoute(builder: (context) => const AdminPage());

        Navigator.push(context, route);
      }
    } else {
      buttonPressed();
      _loginErrorDialog(context);
    }
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _userNameController.dispose();
    super.dispose();
  }

  Future<dynamic> exitDialog() {
    return showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
      title: const Text('Seguro(a) que desea salir?', style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: Colors.black),
      ),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context).pop(false);
        }, style: const ButtonStyle(
          alignment: Alignment.bottomLeft,),
          child: const Text('NO', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Colors.red),
          ),),
        TextButton(onPressed: () {
          exit(0);

        }, child: const Text('SÍ',textAlign: TextAlign.right, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.blue),),)
      ],
    ),);
  }
  final bool _allow = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('LAMMU  APP')),
          leading: GestureDetector(
            onTap: () {exitDialog();},
            child: const Icon(
              Icons.exit_to_app,
              size: 40,
              color: Colors.white,
              // add custom icons also
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 25),
                  //bienvenido de vuelta
                  Text(
                    "Bienvenido(a) de vuelta!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.blue[500]),
                  ),
                  const SizedBox(height: 20),

                  Image.asset(
                    'images/user.png',
                    scale: 3,
                  ),
                  const SizedBox(height: 20),

                  //user textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _userNameController,
                          style: const TextStyle(color: Colors.blue),
                          decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                            border: InputBorder.none,
                            hintText: '   Nombre de usuario',
                            hintStyle: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  //contrasenia textfield
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          style: const TextStyle(color: Colors.blue),
                          decoration: InputDecoration(
                            suffixIcon: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                              child: Icon(_obscureText
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: Colors.blue,
                            ),
                            border: InputBorder.none,
                            hintText: '   Contraseña',
                            hintStyle: const TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  //boton de iniciar sesion
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100.0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          showLoaderDialog(context);
                          signIn();
                        });
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(200),
                          boxShadow: isButtonPressed
                              ? [
                                  // no shadows if button is pressed
                                ]
                              : [
                                  //darker shadow on bottom right
                                  BoxShadow(
                                    color: Colors.grey.shade800,
                                    offset: const Offset(6, 6),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  ),

                                  //lighter shadow on top left
                                  const BoxShadow(
                                    color: Colors.white,
                                    offset: Offset(-6, -6),
                                    blurRadius: 15,
                                    spreadRadius: 1,
                                  )
                                ],
                        ),
                        child: const Center(
                            child: Text(
                          'Iniciar Sesión',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        )),
                      ),
                    ),
                  ),

                  // ignore: prefer_const_constructors
                  SizedBox(height: 70),
                  //acerca de la app

                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          final route =
                              MaterialPageRoute(builder: (context) => AboutApp());

                          // ignore: use_build_context_synchronously
                          Navigator.push(context, route);
                        },
                        child: const Text(
                          'Acerca de LAMMU   ',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      onWillPop: () {
        return Future.value(_allow); // if true allow back else block it
      },
    );
  }
}

void _loginErrorDialog(BuildContext context) {
  AlertDialog alert = const AlertDialog(
    title: Text(
      "Usuario o Contraseña inválido",
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    content: Text(
      "Intente nuevamente!",
      textAlign: TextAlign.center,
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    backgroundColor: Colors.red,
  );

  Navigator.pop(context);

  showDialog(
      context: context,
      builder: (BuildContext buildercontext) {
        return alert;
      });
}

showLoaderDialog(BuildContext context) {
  AlertDialog alert = AlertDialog(
    content: Row(
      children: [
        const CircularProgressIndicator(),
        Container(
            margin: const EdgeInsets.only(left: 7),
            child: const Text("Cargando...")),
      ],
    ),
  );
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
