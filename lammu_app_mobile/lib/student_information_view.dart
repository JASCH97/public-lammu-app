import 'package:flutter/material.dart';
import 'package:lammu_app/read_google_sheets.dart';

class StudentInformationView extends StatefulWidget {
  const StudentInformationView({super.key});
  @override
  State<StudentInformationView> createState() => _StudentInformationViewState();
}

class _StudentInformationViewState extends State<StudentInformationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              Text(
                "Resultado de la búsqueda: ", textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.blue[500]),
              ),
              const SizedBox(height: 20),

              Image.asset(
                'images/lupa.png',
                scale: 30,
              ),
              const SizedBox(height: 20),
              const Text(
                "Nombre:", textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Text(
                studentInformation[0], textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              const SizedBox(height: 50),
              const Text(
                "Año:",textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Text(
                studentInformation[1],textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              const SizedBox(height: 50),
              const Text(
                "Sección:",textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Text(
                studentInformation[2], textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              const SizedBox(height: 50),
              const Text(
                "Auxiliar:",textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Text(
                studentInformation[3],textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              const SizedBox(height: 50),
              const Text(
                "Orientador(a):",textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Text(
                studentInformation[4],textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              const SizedBox(height: 50),
              const Text(
                "Profesor(a) Guía:",textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Text(
                studentInformation[5],textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              const SizedBox(height: 50),
              const Text(
                "Nombre del tutor(a) legal:",textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Text(
                studentInformation[6],textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              const SizedBox(height: 50),
              const Text(
                "Correo del tutor(a) legal:",textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Text(
                studentInformation[7],textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              const SizedBox(height: 50),
              const Text(
                "Número del tutor(a) legal:",textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Text(
                studentInformation[8],textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              const SizedBox(height: 50),
              const Text(
                "Estado del estudiante:",textAlign: TextAlign.center,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.blue),
              ),
              const SizedBox(height: 12),
              Text(
                studentInformation[9],textAlign: TextAlign.center,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.black),
              ),
              const SizedBox(height: 50),


              // ignore: prefer_const_constructors
              SizedBox(height: 70),
            ])))));
  }
}
