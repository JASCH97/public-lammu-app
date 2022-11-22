import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lammu_app/login_page.dart';
import 'package:lammu_app/section_selection_list4ParentsEmails.dart';
import 'package:lammu_app/section_selection_search.dart';
import 'package:lammu_app/send_teachers_emails.dart';
import 'read_google_sheets.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({super.key});
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  bool isButtonSearchPressed = false;

  void buttonPressed() {
    setState(() {
      if (isButtonSearchPressed == false) {
        isButtonSearchPressed = true;
      } else if (isButtonSearchPressed == true) {
        isButtonSearchPressed = false;
      }
    });
  }

  Future selectSection() async {
    buttonPressed();
    final route =
        MaterialPageRoute(builder: (context) => const SectionSelectionSearch());
    Navigator.push(context, route);
    buttonPressed();
  }

  Future teachersEmail() async {
    buttonPressed();
    setAllTeachersEmailsFromSheets();
    //print(allTeachersEmails);
    final route = MaterialPageRoute(builder: (context) => SendTeachersEmails());
    Navigator.push(context, route);
    buttonPressed();
  }

  Future<dynamic> exitDialog() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text(
          'Seguro(a) que desea salir?',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 26, color: Colors.black),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            style: const ButtonStyle(
              alignment: Alignment.bottomLeft,
            ),
            child: const Text(
              'NO',
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 26, color: Colors.red),
            ),
          ),
          TextButton(
            onPressed: () {
              exit(0);
            },
            child: const Text(
              'SÍ',
              textAlign: TextAlign.right,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                  color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }

  void sectionSelection4Emails() {
    buttonPressed();
    final route = MaterialPageRoute(
        builder: (context) => const SectionSelectionList4ParentsEmails());
    Navigator.push(context, route);
    buttonPressed();
  }

  Future<bool> back2LoginPage() {
    final route =
    MaterialPageRoute(builder: (context) => LoginPage());

    // ignore: use_build_context_synchronously
    Navigator.push(context, route);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { return back2LoginPage(); },
      child: Scaffold(
          appBar: AppBar(
            title: const Center(
                child: Text('LAMMU  APP', textAlign: TextAlign.center)),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Center(
                  child: SingleChildScrollView(
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                const SizedBox(height: 25),
                //Saludo segun el rol
                Center(
                  child: Text(
                    "Hola Administrador(a):",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.blue[500]),
                  ),
                ),
                Text(
                  LoginPage.fullName.toString(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.blue[500]),
                ),
                const SizedBox(height: 20),
                Text(
                  "Qué desea realizar?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue[500]),
                ),
                const SizedBox(height: 5),

                Image.asset(
                  'images/questionIcon.png',
                  scale: 3,
                ),
                const SizedBox(height: 20),

                //boton enviar comunicado a profesores
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90.0),
                  child: GestureDetector(
                    onTap: teachersEmail,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(200),
                        boxShadow: isButtonSearchPressed
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
                        'Enviar comunicado a profesores',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                //boton para enviar comunicados a tutores legales
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90.0),
                  child: GestureDetector(
                    onTap: sectionSelection4Emails,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(200),
                        boxShadow: isButtonSearchPressed
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
                        'Enviar comunicado a padres de familia',
                        textAlign: TextAlign.center,
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
                SizedBox(height: 20),

                //boton para buscar informacion de estudiante
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90.0),
                  child: GestureDetector(
                    onTap: selectSection,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(200),
                        boxShadow: isButtonSearchPressed
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
                        'Buscar información de un estudiante',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //boton de salir
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 90.0),
                  child: GestureDetector(
                    onTap: exitDialog,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.red[300],
                        borderRadius: BorderRadius.circular(200),
                        boxShadow: isButtonSearchPressed
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
                        'Salir',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      )),
                    ),
                  ),
                ),

                // ignore: prefer_const_constructors
                SizedBox(height: 70),
              ]))))),
    );
  }
}
