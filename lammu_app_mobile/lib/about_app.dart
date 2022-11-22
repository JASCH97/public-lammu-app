import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'admin_page.dart';
import 'read_google_sheets.dart';
import 'professor_page.dart';


// ignore: use_key_in_widget_constructors
class AboutApp extends StatefulWidget {

  @override
  State<AboutApp> createState() => _AboutAppState();
}

class _AboutAppState extends State<AboutApp> {
  String text =
  """La motivación para crear esta herramienta nació después de estudiar el manejo de la información que tiene implementado el Liceo de Atenas Martha Mirambell Umaña. Encontramos que el sistema actual es un poco tedioso de utilizar; podemos calificarlo de rudimentario y poco eficiente. Nuestro equipo de trabajo, JORO, considera que este proyecto puede optimizar algunas funcionalidades diarias que son fundamentales para los profesores y administrativos del liceo.
\n
Aplicación creada por los estudiantes del Instituto Tecnológico de Costa Rica:
-Joan Sánchez Chinchilla 
(joansanchez@estudiantec.cr)

-Rodrigo Espinach Hernández 
(rodri2210eh@estudiantec.cr)
\n
A cargo de los profesores de la misma institución:
-Aurelio Sanabria Rodríguez 
(ausanabria@itcr.ac.cr)

-María Estrada Sánchez 
(mestrada@itcr.ac.cr)
  """;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('LAMMU  APP')),
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
                  "¿Cómo nace LAMMU APP?",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      color: Colors.blue[500]),
                ),
                //const SizedBox(height: 1),

                Image.asset(
                  'images/ideaIcon.png',
                  scale: 9,
                ),
                const SizedBox(height: 20),
                Text(
                  text, textAlign: TextAlign.center,
                  style: const TextStyle(

                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.black),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}

