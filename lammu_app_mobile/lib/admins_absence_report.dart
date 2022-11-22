import 'package:flutter/material.dart';
import 'package:lammu_app/professor_page.dart';
import 'package:lammu_app/read_google_sheets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:lammu_app/section_selection_list.dart';

class AdminsAbsenceReport extends StatefulWidget {
  const AdminsAbsenceReport({super.key});
  @override
  State<AdminsAbsenceReport> createState() => _AdminsAbsenceReportState();
}

class _AdminsAbsenceReportState extends State<AdminsAbsenceReport> {
  List<String> notSelectedStudents = getNotSelectedStudents();


  Future sendEmail() async {
    final allRecipients = [auxiliarEmail,orientadorEmail,profesorGuiaEmail];
    String students = "";
    for (int i = 0; i < notSelectedStudents.length;i++){
      students = "$students-${notSelectedStudents[i]}\n";
    }
    final Email email = Email(
      body: 'Hola! Este es un mensaje automático generado por la aplicación del Liceo de Atenas "LAMMU".\n\nLos siguientes estudiantes de la sección $finalSection se encuentran ausentes el día de hoy:\n$students\n\nEn la asignatura de: \n\nSaludos.',
      subject: 'Ausencia en clases',
      //recipients: ['joansc16@gmail.com','joansctec@gmail.com','lammuapp@gmail.com'],
      recipients: allRecipients,
      //cc: [''],
      //bcc: [''],
      //attachmentPaths: [''],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }


  Future<dynamic> exitDialog() {
    print(finalSection + auxiliarEmail + orientadorEmail + profesorGuiaEmail);
    print(getParentsEmailsForReport());
    return showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
      title: const Text('Seguro(a) que desea continuar?', style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 26,
          color: Colors.black),
      ),
      actions: [
        TextButton(onPressed: () {
          Navigator.of(context).pop(false);
        }, style: ButtonStyle(
          alignment: Alignment.bottomLeft,),
          child: const Text('NO', style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 26,
              color: Colors.red),
          ),),
        TextButton(onPressed: () {
          sendEmail();
          final route =
          MaterialPageRoute(builder: (context) => const ProfessorPage());

          // ignore: use_build_context_synchronously
          Navigator.push(context, route);

        }, child: const Text('SÍ',textAlign: TextAlign.right, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.blue),),)
      ],
    ),);
  }

  Future<dynamic> backToSelectSection() {
    return showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
      title: const Text('Si se devuelve ahora, no se enviará el reporte de ausencias al auxiliar, orientador y profesor guía\n\nDesea devolverse igualmente?', style: TextStyle(
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
          final route =
          MaterialPageRoute(builder: (context) => const SectionSelectionList());

          // ignore: use_build_context_synchronously
          Navigator.push(context, route);

        }, child: const Text('SÍ',textAlign: TextAlign.right, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.blue),),)
      ],
    ),);
  }

  Future<bool> back2StudentsList() {
    backToSelectSection();
    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () { return back2StudentsList(); },
      child: Scaffold(
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
                  Text(
                    "A continuación se enviará un reporte de ausencias de la sección $finalSection por correo electrónico a:\n\n-Auxiliar\n-Orientador\n-Profesor Guía",
                    style: TextStyle(

                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: Colors.blue[500]),

                  ),
                  const SizedBox(height: 55),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25,
                      vertical: 10,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      child: GestureDetector(
                        onTap: exitDialog,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          padding: const EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(200),
                          ),
                          child: const Center(
                              child: Text(
                                "Continuar con el reporte",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )),
                        ),
                      ),
                    ),
                  ),

                  // ignore: prefer_const_constructors
                  SizedBox(height: 70),
                  //acerca de la app

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}