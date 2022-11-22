// ignore_for_file: unnecessary_this

import 'package:flutter/material.dart';
import 'package:lammu_app/check_list_bySection.dart';
import 'package:lammu_app/professor_page.dart';
import 'package:lammu_app/read_google_sheets.dart';
import 'package:lammu_app/uniformVerification.dart';

class SectionSelectionUniform extends StatefulWidget {
  const SectionSelectionUniform({super.key});
  @override
  State<SectionSelectionUniform> createState() =>
      _SectionSelectionUniformState();
}

class _SectionSelectionUniformState extends State<SectionSelectionUniform> {
  List<String> section = [];

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

  List<DropdownMenuItem<String>> menuItems = [];
  String yearValue = "Ninguno";
  String sectionValue = "Ninguno";
  bool disabledDropDown = true;

  final sevethSection = {
    "1": "7-1",
    "2": "7-2",
    "3": "7-3",
    "4": "7-4",
    "5": "7-5",
    "6": "7-6",
    "7": "7-7",
    "8": "7-8",
    "9": "7-9",
    "10": "7-10",
    "11": "7-11",
    "12": "7-12",
    "13": "7-13",
    "14": "7-14",
    "15": "7-15",
  };

  final eighthSection = {
    "1": "8-1",
    "2": "8-2",
    "3": "8-3",
    "4": "8-4",
    "5": "8-5",
    "6": "8-6",
    "7": "8-7",
    "8": "8-8",
    "9": "8-9",
    "10": "8-10",
    "11": "8-11",
    "12": "8-12",
    "13": "8-13",
    "14": "8-14",
    "15": "8-15",
  };

  final ninthSection = {
    "1": "9-1",
    "2": "9-2",
    "3": "9-3",
    "4": "9-4",
    "5": "9-5",
    "6": "9-6",
    "7": "9-7",
    "8": "9-8",
    "9": "9-9",
    "10": "9-10",
    "11": "9-11",
    "12": "9-12",
    "13": "9-13",
    "14": "9-14",
    "15": "9-15",
  };

  final tenthSection = {
    "1": "10-1",
    "2": "10-2",
    "3": "10-3",
    "4": "10-4",
    "5": "10-5",
    "6": "10-6",
    "7": "10-7",
    "8": "10-8",
    "9": "10-9",
    "10": "10-10",
    "11": "10-11",
    "12": "10-12",
    "13": "10-13",
    "14": "10-14",
    "15": "10-15",
  };

  final eleventhSection = {
    "1": "11-1",
    "2": "11-2",
    "3": "11-3",
    "4": "11-4",
    "5": "11-5",
    "6": "11-6",
    "7": "11-7",
    "8": "11-8",
    "9": "11-9",
    "10": "11-10",
    "11": "11-11",
    "12": "11-12",
    "13": "11-13",
    "14": "11-14",
    "15": "11-15",
  };

  final twelfSection = {
    "1": "12-1",
    "2": "12-2",
    "3": "12-3",
    "4": "12-4",
    "5": "12-5",
  };

  void populateSpecificSection(int option) {
    if (option == 1) {
      for (String key in sevethSection.keys) {
        menuItems.add(DropdownMenuItem<String>(
          value: sevethSection[key],
          child: Text(
            sevethSection[key]!,
            style: const TextStyle(fontSize: 22),
          ),
        ));
      }
    } else if (option == 2) {
      for (String key in eighthSection.keys) {
        menuItems.add(DropdownMenuItem<String>(
          value: eighthSection[key],
          child: Text(
            eighthSection[key]!,
            style: const TextStyle(fontSize: 22),
          ),
        ));
      }
    } else if (option == 3) {
      for (String key in ninthSection.keys) {
        menuItems.add(DropdownMenuItem<String>(
          value: ninthSection[key],
          child: Text(
            ninthSection[key]!,
            style: const TextStyle(fontSize: 22),
          ),
        ));
      }
    } else if (option == 4) {
      for (String key in tenthSection.keys) {
        menuItems.add(DropdownMenuItem<String>(
          value: tenthSection[key],
          child: Text(
            tenthSection[key]!,
            style: const TextStyle(fontSize: 22),
          ),
        ));
      }
    } else if (option == 5) {
      for (String key in eleventhSection.keys) {
        menuItems.add(DropdownMenuItem<String>(
          value: eleventhSection[key],
          child: Text(
            eleventhSection[key]!,
            style: const TextStyle(fontSize: 22),
          ),
        ));
      }
    } else if (option == 6) {
      for (String key in twelfSection.keys) {
        menuItems.add(DropdownMenuItem<String>(
          value: twelfSection[key],
          child: Text(
            twelfSection[key]!,
            style: const TextStyle(fontSize: 22),
          ),
        ));
      }
    }
  }

  // ignore: no_leading_underscores_for_local_identifiers
  void yearValueChanged(_yearValue) {
    if (_yearValue == "Séptimo") {
      menuItems = [];
      populateSpecificSection(1);
    } else if (_yearValue == "Octavo") {
      menuItems = [];
      populateSpecificSection(2);
    } else if (_yearValue == "Noveno") {
      menuItems = [];
      populateSpecificSection(3);
    } else if (_yearValue == "Décimo") {
      menuItems = [];
      populateSpecificSection(4);
    } else if (_yearValue == "Undécimo") {
      menuItems = [];
      populateSpecificSection(5);
    } else if (_yearValue == "Duodécimo") {
      menuItems = [];
      populateSpecificSection(6);
    }

    setState(() {
      yearValue = _yearValue;
      sectionValue = "Ninguno";
      disabledDropDown = false;
    });
  }

  // ignore: no_leading_underscores_for_local_identifiers
  void secondYearValueChanged(_sectionValue) {
    setState(() {
      sectionValue = _sectionValue;
    });
  }

  void getSectionList() async {
    setFinalSection(sectionValue);
    if (yearValue == "Ninguno" || sectionValue == "Ninguno") {
      _DataErrorDialog(context);
    } else {
      getListOfStudentsBySection(sectionValue);
      //_fetchData(context); //arreglar el cargando
      await Future.delayed(const Duration(seconds: 5));
      Navigator.of(context).pop();
      if (listOfStudentsBySection.isEmpty) {
        _emptySectionList(context);
      } else{
        final route =
        MaterialPageRoute(builder: (context) => const UniformVerification());
        // ignore: use_build_context_synchronously
        Navigator.push(context, route);
      }
    }
  }

  Future<String?> getFinalSection() async {
    return sectionValue;
  }

  Future<bool> back2ProfesorPage() {
    final route =
    MaterialPageRoute(builder: (context) => const ProfessorPage());

    // ignore: use_build_context_synchronously
    Navigator.push(context, route);
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { return back2ProfesorPage(); },
      child: Scaffold(
          appBar: AppBar(
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
                const SizedBox(height: 20),
                Center(
                  child: Center(
                    child: Text(
                      " Ingrese la sección de la que desea verificar el uniforme:",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Colors.blue[500]),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                Image.asset(
                  'images/lupa.png',
                  scale: 30,
                ),

                const SizedBox(height: 20),

                //SELECCIONAR EL AñO
                Center(
                  child: DropdownButton<String>(
                    items: const [
                      DropdownMenuItem<String>(
                        value: "Séptimo",
                        child: Center(
                          child: Text(
                            "Séptimo",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: "Octavo",
                        child: Center(
                          child: Text(
                            "Octavo",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: "Noveno",
                        child: Center(
                          child: Text(
                            "Noveno",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: "Décimo",
                        child: Center(
                          child: Text(
                            "Décimo",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: "Undécimo",
                        child: Center(
                          child: Text(
                            "Undécimo",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                      DropdownMenuItem<String>(
                        value: "Duodécimo",
                        child: Center(
                          child: Text(
                            "Duodécimo",
                            style: TextStyle(fontSize: 22),
                          ),
                        ),
                      ),
                    ],
                    onChanged: (_yearValue) => yearValueChanged(_yearValue),
                    hint: const Text("Seleccione el nivel",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 22,
                        )),
                  ),
                ),

                const Text(
                  "Ha selecionado el nivel:",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 22),
                ),
                Text(
                  yearValue,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 22),
                ),
                const SizedBox(height: 30),

                //SELECCIONAR LA SECCION SEGUN EL AñO
                Center(
                  child: DropdownButton<String>(
                    items: menuItems,
                    onChanged: disabledDropDown
                        ? null
                        : (sectionValue) => secondYearValueChanged(sectionValue),
                    hint: const Text(
                      "Seleccione la sección",
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),

                const Text(
                  "Ha selecionado la sección:",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue, fontSize: 22),
                ),
                Text(
                  sectionValue,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black, fontSize: 22),
                ),
                const SizedBox(height: 40),
                //boton buscar informacion de estudiante
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 100.0),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _showLoaderDialog(context);
                        getSectionList();
                      });
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(15),
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
                        'Buscar',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
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

// ignore: non_constant_identifier_names
void _DataErrorDialog(BuildContext context) {
  AlertDialog alert = const AlertDialog(
    title: Text(
      "Debe seleccionar el año y la sección primero!",
      style: TextStyle(
          fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    backgroundColor: Colors.red,
  );
  Navigator.of(context).pop();
  showDialog(
      context: context,
      builder: (BuildContext buildercontext) {
        return alert;
      });
}

// ignore: non_constant_identifier_names
void _emptySectionList(BuildContext context) {
  AlertDialog alert = const AlertDialog(
    title: Text(
      "No se encontraron estudiantes en esta sección :(",
      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    backgroundColor: Colors.red,
  );
  showDialog(
      context: context,
      builder: (BuildContext buildercontext) {
        return alert;
      });
}

_showLoaderDialog(BuildContext context) {
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
