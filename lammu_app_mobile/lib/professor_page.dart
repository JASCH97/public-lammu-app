import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lammu_app/login_page.dart';
import 'package:lammu_app/section_selection_4parentEmailSearch.dart';
import 'package:lammu_app/section_selection_list.dart';
import 'package:lammu_app/section_selection_search.dart';
import 'package:lammu_app/section_selection_uniform.dart';

class ProfessorPage extends StatefulWidget {
  const ProfessorPage({super.key});
  @override
  State<ProfessorPage> createState() => _ProfessorPageState();
}

class _ProfessorPageState extends State<ProfessorPage> {
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

  Future selectSection4List() async {
    buttonPressed();
    final route =
        MaterialPageRoute(builder: (context) => const SectionSelectionList());
    Navigator.push(context, route);
    buttonPressed();
  }

  Future selectSectionList() async {
    buttonPressed();
    final route =
        MaterialPageRoute(builder: (context) => const SectionSelectionSearch());
    Navigator.push(context, route);
    buttonPressed();
  }

  Future selectSection4ParentEmail() async {
    buttonPressed();
    final route = MaterialPageRoute(
        builder: (context) => const SectionSelection4ParentEmailSearch());
    Navigator.push(context, route);
    buttonPressed();
  }

  Future selectSectionUniform() async {
    buttonPressed();
    final route = MaterialPageRoute(
        builder: (context) => const SectionSelectionUniform());
    Navigator.push(context, route);
    buttonPressed();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
        leading: GestureDetector(
        onTap: () { final route = MaterialPageRoute(
            builder: (context) => LoginPage());
        Navigator.push(context, route); },
    child: const Icon(
    Icons.chevron_left,
      size: 40,
      // add custom icons also
    ),),
          title: const Center(
            child: Text(
              'LAMMU  APP',
              textAlign: TextAlign.center,
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
              //Saludo segun el rol
              Text(
                "Hola Profesor(a):",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.blue[500]),
              ),
              Text(
                LoginPage.fullName.toString(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
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

              //boton para pasar lista
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90.0),
                child: GestureDetector(
                  onTap: selectSection4List,
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
                      'Pasar lista',textAlign: TextAlign.center,
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

              //boton para reportar uniforme incompleto
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90.0),
                child: GestureDetector(
                  onTap: selectSectionUniform,
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
                      'Reporte de uniforme incompleto', textAlign: TextAlign.center,
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
                  onTap: selectSectionList,
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
                      'Buscar información de un estudiante', textAlign: TextAlign.center,
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

              //boton enviar comunicado a padre de familia (ver si se puede implementar mejor a la hora de pasar lista)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 90.0),
                child: GestureDetector(
                  onTap: selectSection4ParentEmail,
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
                      'Enviar comunicado a tutor legal', textAlign: TextAlign.center,
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
            ])))));
  }
}
