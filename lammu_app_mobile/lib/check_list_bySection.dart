import 'package:flutter/material.dart';
import 'package:lammu_app/absence%20_report.dart';
import 'package:lammu_app/professor_page.dart';
import 'package:lammu_app/student.dart';
import 'read_google_sheets.dart';

class CheckListBySection extends StatefulWidget {
  const CheckListBySection({super.key});
  @override
  State<CheckListBySection> createState() => _CheckListBySectionState();
}

class _CheckListBySectionState extends State<CheckListBySection> {
  List<Student> studentsBySection = listOfStudentsBySection;
  List<String> notSelectedStudents = [];
  List<int> notSelectedStudentsIndex = [];
  List<String> parentsEmailsFound = [];

  List<String> getStudents(){
    //print(notSelectedStudents);
    return notSelectedStudents;
  }


  void choosePath() {
    if(notSelectedStudents.isEmpty){
      noAbsenceDialog();
    } else {
      sendReportsDialog();
    }
  }

  Future<dynamic> sendReportsDialog() {
    setNotSelectedStudents(notSelectedStudents);
    setParentsEmailsForReport(getParentsEmails());
    print(finalSection + auxiliarEmail + orientadorEmail + profesorGuiaEmail);
    print(getParentsEmailsForReport());
    return showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
      title: const Text('Se ha pasado lista correctamente!\n\nA continuación, se enviará un correo electrónico a los padres de familia para notificarles de la ausencia de sus hijos.', style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black),
      ),
      content: const Text('Desea continuar?',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black),),

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
          sendReportsDialog();
          final route =
          MaterialPageRoute(builder: (context) => const AbsenceReport());

          // ignore: use_build_context_synchronously
          Navigator.push(context, route);

        }, child: const Text('SÍ',textAlign: TextAlign.right, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.blue),),)
      ],
    ),);
  }

  Future<dynamic> noAbsenceDialog() {
    return showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
      title: const Text('La clase está completa! No hay ausencias el día de hoy.\n', style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black),
      ),
      content: const Text('Terminar de pasar lista?',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black),),

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


  //se consiguen los correos de los padres de familia para los estudiantes ausentes
  List<String> getParentsEmails() {
    parentsEmailsFound = [];
    for (int i = 0; i < notSelectedStudentsIndex.length; i++) {
      if (allParentsEmails[notSelectedStudentsIndex[i]].isNotEmpty) {
        parentsEmailsFound.add(allParentsEmails[notSelectedStudentsIndex[i]]);
      }
    }

    return parentsEmailsFound;
    //print(parentsEmailsFound);
  }

  void secureDeleteIndex(int index) {
    for (int i = 0; i < notSelectedStudentsIndex.length; i++) {
      if (notSelectedStudentsIndex[i] == index) {
        notSelectedStudentsIndex.remove(notSelectedStudentsIndex[i]);
        i = i - 1;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
              child: Text("Sección: $finalSection",
                  textAlign: TextAlign.center)),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: studentsBySection.length,
                      itemBuilder: (BuildContext context, int index) {
                        return studentItem(
                          "\n${studentsBySection[index].name}",
                          studentsBySection[index].isSelected,
                          index,
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
                      onTap: choosePath,
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: const Center(
                            child: Text(
                              "Pasar Lista",
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
            )));
  }

  Widget studentItem(String name, bool isSelected, int index) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.airline_seat_recline_normal_outlined,
          color: Colors.white,
          size: 30,
        ),
      ),
      title: Text(
        "$name\n\n\n",
        style: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: isSelected
          ? const Icon(
        Icons.check_circle,
        color: Colors.green,
      )
          : const Icon(Icons.check_circle_outline, color: Colors.grey),
      onTap: () {
        setState(() {
          //se cambia el valor seleccionado del estudiante
          if (studentsBySection[index].isSelected == true ) {
            studentsBySection[index].isSelected = false;
          } else if (studentsBySection[index].isSelected == false ) {
            studentsBySection[index].isSelected = true;
          }

          if (studentsBySection[index].isSelected == false) {
            notSelectedStudents.add(studentsBySection[index].name);
            notSelectedStudentsIndex.add(index);
          } else {
            notSelectedStudents.remove(studentsBySection[index].name);
            secureDeleteIndex(index);
          }
          print(notSelectedStudents);
          //print(notSelectedStudentsIndex);

        });
      },
    );
  }
}
