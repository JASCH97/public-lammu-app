import 'package:flutter/material.dart';
import 'package:lammu_app/admins_absence_report.dart';
import 'package:lammu_app/check_list_bySection.dart';
import 'package:lammu_app/read_google_sheets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:lammu_app/section_selection_list.dart';

class AbsenceReport extends StatefulWidget {
  const AbsenceReport({super.key});
  @override
  State<AbsenceReport> createState() => _AbsenceReportState();
}

class _AbsenceReportState extends State<AbsenceReport> {
  List<String> notSelectedStudents = getNotSelectedStudents();


  Future sendEmail() async {
    final allRecipients = getParentsEmailsForReport();
    //allRecipients.add(auxiliarEmail);
    //allRecipients.add(orientadorEmail);
    //allRecipients.add(profesorGuiaEmail);

    final Email email = Email(
      body: 'Hola! Este es un mensaje automático generado por la aplicación del Liceo de Atenas "LAMMU".\n\nSe le informa que su hijo(a) en este momento no se encuentra en clases.\n\nPara más información puede ponerse en contacto con el auxiliar por medio de su correo: $auxiliarEmail.\nTambién puede llamar al Liceo al número: 2446 5124\n\nSaludos.',
      subject: 'Ausencia en clases',
      //recipients: ['joansc16@gmail.com','joansctec@gmail.com','lammuapp@gmail.com'],
      //recipients: allRecipients,
      //cc: [''],
      bcc: allRecipients,
      //attachmentPaths: [''],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  Future<dynamic> exitDialog() {
    print(finalSection + auxiliarEmail + orientadorEmail + profesorGuiaEmail);
    print(getParentsEmailsForReport());
    return showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
      title: const Text('Seguro(a) que desea continuar con el reporte?', style: TextStyle(
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
          sendEmail();
          final route =
          MaterialPageRoute(builder: (context) => const AdminsAbsenceReport());

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
      title: const Text('Si se devuelve ahora, deberá pasar lista nuevamente\n\nDesea volver igualmente?', style: TextStyle(
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
            title: const Center(
                child: Text("AUSENTES",
                    textAlign: TextAlign.center)),
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                        itemCount: notSelectedStudents.length,
                        itemBuilder: (BuildContext context, int index) {
                          return notSelected(
                            "\n${notSelectedStudents[index]}",
                          );
                        }),
                  ),
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
                                "Enviar Reporte",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              )),
                        ),
                      ),
                    ),
                  )


                ],
              ))),
    );
  }

}

Widget notSelected(String name) {
  return ListTile(
    leading: const CircleAvatar(
      backgroundColor: Colors.blue,
      child: Icon(
        Icons.person_outline_outlined,
        color: Colors.white,
      ),
    ),
    title: Text(
      "$name\n\n\n",
      style: const TextStyle(
        fontWeight: FontWeight.w500,
      ),
    ),

  );
}
