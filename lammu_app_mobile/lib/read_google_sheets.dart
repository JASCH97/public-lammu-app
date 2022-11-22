import 'dart:async';
import 'package:gsheets/gsheets.dart';
import 'package:lammu_app/student.dart';

// your google auth credentials
const _credentials = r'''
{
  "type": "",
  "project_id": "",
  "private_key_id": "",
  "private_key": "",
  "client_email": "",
  "client_id": "",
  "auth_uri": "",
  "token_uri": "",
  "auth_provider_x509_cert_url": "",
  "client_x509_cert_url": ""
}

''';

// your spreadsheet id
const _spreadsheetId = '';

List<String> studentInformation = [];
String finalSection = "";
List<Student> listOfStudentsBySection = [];
List<String> allParentsEmails = [];
List<String> allTeachersEmails = [];
List<String> parentsEmailsForReport = [];
List<String> notSelectedStudents = [];
String auxiliarEmail = "";
String orientadorEmail = "";
String profesorGuiaEmail = "";

List<String> getAllTeacherssEmails() {
  return allTeachersEmails;
}

void setAllParentsEmails(List<String> emails) {
  allParentsEmails = emails;
}

List<String> getAllParentsEmails() {
  return allParentsEmails;
}


void setParentsEmailsForReport(List<String> emails) {
  parentsEmailsForReport = emails;
}

List<String> getParentsEmailsForReport() {
  return parentsEmailsForReport;
}

String? getAuxiliarEmail() {
  return auxiliarEmail;
}

String getOrientadorEmail() {
  return orientadorEmail;
}

String getProfesorGuiaEmail() {
  return profesorGuiaEmail;
}

void setAuxiliarEmail(String email) {
  auxiliarEmail = email;
}

void setOrientadorEmail(String email) {
  orientadorEmail = email;
}

void setProfesorGuiaEmail(String email) {
  profesorGuiaEmail = email;
}

void setFinalSection(String nfs) {
  finalSection = nfs;
}

String getFinalSection() {
  return finalSection;
}

void setNotSelectedStudents(List<String> students) {
  notSelectedStudents = students;
}

List<String> getNotSelectedStudents() {
  return notSelectedStudents;
}

void setAllTeachersEmailsFromSheets() async {
  allTeachersEmails = [];
  List<String> teachersEmailsFound = [];
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  final sheet = ss.worksheetByTitle('Correos Profesores');

  // se almacenan todos los correos de profesores en una lista
  var emails = await sheet?.values.column(1, fromRow: 2, length: 50);

  for (var email in emails!) {
    allTeachersEmails.add(email.toString());
    //teachersEmailsFound.add(email.toString());
  }

  //setAllTeacherssEmails(teachersEmailsFound);
  //print(allTeachersEmails);

}

void getListOfStudentsBySection(String section) async {
  //reset to de students list
  listOfStudentsBySection = [];
  allParentsEmails = [];

  List<String>? students;
  List<String>? parentsEmails;
  Worksheet? sheet;
  //reset de la informacion del estudiante
  studentInformation = [];
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);

  //obtener lista de estud para SEPTIMOS
  if (section[0] == "7") {
    sheet = ss.worksheetByTitle('Septimo');
  } else if (section[0] == "8") {
    sheet = ss.worksheetByTitle('Octavo');
  } else if (section[0] == "9") {
    sheet = ss.worksheetByTitle('Noveno');
  } else if (section.substring(0, 2) == "10") {
    sheet = ss.worksheetByTitle('Decimo');
  } else if (section.substring(0, 2) == "11") {
    sheet = ss.worksheetByTitle('Undecimo');
  } else if (section.substring(0, 2) == "12") {
    sheet = ss.worksheetByTitle('Duodecimo');
  }
  //el auxiliar es global por año, por lo que se mantiene siempre en esa posicion
  setAuxiliarEmail(await sheet!.values.value(row: 2, column: 5));

  if (section[0] == "7" || section[0] == "8" || section[0] == "9") {
    if (section[2] == "1" && section.length == 3) {
      // se almacenan los estudiantes de la seccion 1 en la variable students
      students = await sheet?.values.column(3, fromRow: 9, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 9, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 5, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 6, column: 5));
    } else if (section[2] == "2") {
      // se almacenan los estudiantes de la seccion 2 en la variable students
      students = await sheet?.values.column(3, fromRow: 55, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 55, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 51, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 52, column: 5));
    } else if (section[2] == "3") {
      // se almacenan los estudiantes de la seccion 3 en la variable students
      students = await sheet?.values.column(3, fromRow: 101, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 101, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 97, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 98, column: 5));
    } else if (section[2] == "4") {
      // se almacenan los estudiantes de la seccion 4 en la variable students
      students = await sheet?.values.column(3, fromRow: 147, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 147, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 143, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 144, column: 5));
    } else if (section[2] == "5") {
      // se almacenan los estudiantes de la seccion 5 en la variable students
      students = await sheet?.values.column(3, fromRow: 193, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 193, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 189, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 190, column: 5));
    } else if (section[2] == "6") {
      // se almacenan los estudiantes de la seccion 6 en la variable students
      students = await sheet?.values.column(3, fromRow: 239, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 239, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 235, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 236, column: 5));
    } else if (section[2] == "7") {
      // se almacenan los estudiantes de la seccion 7 en la variable students
      students = await sheet?.values.column(3, fromRow: 285, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 285, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 281, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 282, column: 5));
    } else if (section[2] == "8") {
      // se almacenan los estudiantes de la seccion 8 en la variable students
      students = await sheet?.values.column(3, fromRow: 331, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 331, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 327, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 328, column: 5));
    } else if (section[2] == "9") {
      // se almacenan los estudiantes de la seccion 9 en la variable students
      students = await sheet?.values.column(3, fromRow: 377, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 377, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 373, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 374, column: 5));
    } else if (section.length > 3) {
      if (section[3] == "0") {
        // se almacenan los estudiantes de la seccion 10 en la variable students
        students = await sheet?.values.column(3, fromRow: 423, length: 40);
        parentsEmails = await sheet?.values.column(6, fromRow: 423, length: 40);
        setOrientadorEmail(await sheet!.values.value(row: 419, column: 5));
        setProfesorGuiaEmail(await sheet!.values.value(row: 420, column: 5));
      } else if (section[3] == "1") {
        // se almacenan los estudiantes de la seccion 11 en la variable students
        students = await sheet?.values.column(3, fromRow: 469, length: 40);
        parentsEmails = await sheet?.values.column(6, fromRow: 469, length: 40);
        setOrientadorEmail(await sheet!.values.value(row: 465, column: 5));
        setProfesorGuiaEmail(await sheet!.values.value(row: 466, column: 5));
      } else if (section[3] == "2") {
        // se almacenan los estudiantes de la seccion 12 en la variable students
        students = await sheet?.values.column(3, fromRow: 515, length: 40);
        parentsEmails = await sheet?.values.column(6, fromRow: 515, length: 40);
        setOrientadorEmail(await sheet!.values.value(row: 511, column: 5));
        setProfesorGuiaEmail(await sheet!.values.value(row: 512, column: 5));
      } else if (section[3] == "3") {
        // se almacenan los estudiantes de la seccion 13 en la variable students
        students = await sheet?.values.column(3, fromRow: 561, length: 40);
        parentsEmails = await sheet?.values.column(6, fromRow: 561, length: 40);
        setOrientadorEmail(await sheet!.values.value(row: 557, column: 5));
        setProfesorGuiaEmail(await sheet!.values.value(row: 558, column: 5));
      } else if (section[3] == "4") {
        // se almacenan los estudiantes de la seccion 14 en la variable students
        students = await sheet?.values.column(3, fromRow: 607, length: 40);
        parentsEmails = await sheet?.values.column(6, fromRow: 607, length: 40);
        setOrientadorEmail(await sheet!.values.value(row: 603, column: 5));
        setProfesorGuiaEmail(await sheet!.values.value(row: 604, column: 5));
      } else if (section[3] == "5") {
        // se almacenan los estudiantes de la seccion 15 en la variable students
        students = await sheet?.values.column(3, fromRow: 653, length: 40);
        parentsEmails = await sheet?.values.column(6, fromRow: 653, length: 40);
        setOrientadorEmail(await sheet!.values.value(row: 649, column: 5));
        setProfesorGuiaEmail(await sheet!.values.value(row: 650, column: 5));
      }
    }
  } else if (section.substring(0, 2) == "10" ||
      section.substring(0, 2) == "11") {
    if (section[3] == "1" && section.length == 4) {
      // se almacenan los estudiantes de la seccion 1 en la variable students
      students = await sheet?.values.column(3, fromRow: 9, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 9, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 5, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 6, column: 5));
    } else if (section[3] == "2") {
      // se almacenan los estudiantes de la seccion 2 en la variable students
      students = await sheet?.values.column(3, fromRow: 55, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 55, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 51, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 52, column: 5));
    } else if (section[3] == "3") {
      // se almacenan los estudiantes de la seccion 3 en la variable students
      students = await sheet?.values.column(3, fromRow: 101, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 101, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 97, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 98, column: 5));
    } else if (section[3] == "4") {
      // se almacenan los estudiantes de la seccion 4 en la variable students
      students = await sheet?.values.column(3, fromRow: 147, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 147, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 143, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 144, column: 5));
    } else if (section[3] == "5") {
      // se almacenan los estudiantes de la seccion 5 en la variable students
      students = await sheet?.values.column(3, fromRow: 193, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 193, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 189, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 190, column: 5));
    } else if (section[3] == "6") {
      // se almacenan los estudiantes de la seccion 6 en la variable students
      students = await sheet?.values.column(3, fromRow: 239, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 239, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 235, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 236, column: 5));
    } else if (section[3] == "7") {
      // se almacenan los estudiantes de la seccion 7 en la variable students
      students = await sheet?.values.column(3, fromRow: 285, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 285, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 281, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 282, column: 5));
    } else if (section[3] == "8") {
      // se almacenan los estudiantes de la seccion 8 en la variable students
      students = await sheet?.values.column(3, fromRow: 331, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 331, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 327, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 328, column: 5));
    } else if (section[3] == "9") {
      // se almacenan los estudiantes de la seccion 9 en la variable students
      students = await sheet?.values.column(3, fromRow: 377, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 377, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 373, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 374, column: 5));
    } else if (section.length > 4) {
      if (section[4] == "0") {
        // se almacenan los estudiantes de la seccion 10 en la variable students
        students = await sheet?.values.column(3, fromRow: 423, length: 40);
        parentsEmails = await sheet?.values.column(6, fromRow: 423, length: 40);
        setOrientadorEmail(await sheet!.values.value(row: 419, column: 5));
        setProfesorGuiaEmail(await sheet!.values.value(row: 420, column: 5));
      } else if (section[4] == "1") {
        // se almacenan los estudiantes de la seccion 11 en la variable students
        students = await sheet?.values.column(3, fromRow: 469, length: 40);
        parentsEmails = await sheet?.values.column(6, fromRow: 469, length: 40);
        setOrientadorEmail(await sheet!.values.value(row: 465, column: 5));
        setProfesorGuiaEmail(await sheet!.values.value(row: 466, column: 5));
      } else if (section[4] == "2") {
        // se almacenan los estudiantes de la seccion 12 en la variable students
        students = await sheet?.values.column(3, fromRow: 515, length: 40);
        parentsEmails = await sheet?.values.column(6, fromRow: 515, length: 40);
        setOrientadorEmail(await sheet!.values.value(row: 511, column: 5));
        setProfesorGuiaEmail(await sheet!.values.value(row: 512, column: 5));
      } else if (section[4] == "3") {
        // se almacenan los estudiantes de la seccion 13 en la variable students
        students = await sheet?.values.column(3, fromRow: 561, length: 40);
        parentsEmails = await sheet?.values.column(6, fromRow: 561, length: 40);
        setOrientadorEmail(await sheet!.values.value(row: 557, column: 5));
        setProfesorGuiaEmail(await sheet!.values.value(row: 558, column: 5));
      } else if (section[4] == "4") {
        // se almacenan los estudiantes de la seccion 14 en la variable students
        students = await sheet?.values.column(3, fromRow: 607, length: 40);
        parentsEmails = await sheet?.values.column(6, fromRow: 607, length: 40);
        setOrientadorEmail(await sheet!.values.value(row: 603, column: 5));
        setProfesorGuiaEmail(await sheet!.values.value(row: 604, column: 5));
      } else if (section[4] == "5") {
        // se almacenan los estudiantes de la seccion 15 en la variable students
        students = await sheet?.values.column(3, fromRow: 653, length: 40);
        parentsEmails = await sheet?.values.column(6, fromRow: 653, length: 40);
        setOrientadorEmail(await sheet!.values.value(row: 649, column: 5));
        setProfesorGuiaEmail(await sheet!.values.value(row: 650, column: 5));
      }
    }
  } else {
    if (section[3] == "1") {
      // se almacenan los estudiantes de la seccion 1 en la variable students
      students = await sheet?.values.column(3, fromRow: 9, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 9, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 5, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 6, column: 5));
    } else if (section[3] == "2") {
      // se almacenan los estudiantes de la seccion 2 en la variable students
      students = await sheet?.values.column(3, fromRow: 55, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 55, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 51, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 52, column: 5));
    } else if (section[3] == "3") {
      // se almacenan los estudiantes de la seccion 3 en la variable students
      students = await sheet?.values.column(3, fromRow: 101, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 101, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 97, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 98, column: 5));
    } else if (section[3] == "4") {
      // se almacenan los estudiantes de la seccion 4 en la variable students
      students = await sheet?.values.column(3, fromRow: 147, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 147, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 143, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 144, column: 5));
    } else if (section[3] == "5") {
      // se almacenan los estudiantes de la seccion 5 en la variable students
      students = await sheet?.values.column(3, fromRow: 193, length: 40);
      parentsEmails = await sheet?.values.column(6, fromRow: 193, length: 40);
      setOrientadorEmail(await sheet!.values.value(row: 189, column: 5));
      setProfesorGuiaEmail(await sheet!.values.value(row: 190, column: 5));
    }
  }

  for (var student in students!) {
    listOfStudentsBySection.add(Student(student.toString(), true));
  }

  for (var parentEmail in parentsEmails!) {
    allParentsEmails.add(parentEmail.toString());
  }

  setAllParentsEmails(allParentsEmails);
}

// ignore: body_might_complete_normally_nullable, non_constant_identifier_names
Future<bool?> validate_user(String userName, String password) async {
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  final sheet = ss.worksheetByTitle('Usuarios');

  // se almacenan todos los nombres de usuario en una lista
  var usuarios = await sheet?.values.column(4, fromRow: 2);

  // se comprueba la existencia del usuario mediante un ciclo
  var existe = false;
  for (var usuario in usuarios!) {
    if (usuario == userName) {
      existe = true;
      // si existe se llama a validar contrasena y se pone break
    }
  }

  if (existe == true) {
    //print('El usuario existe'); // se procede a verificar la contrasena

    //se valida la contrasena en base a la existencia de un nombre de usuario
    var idCont = 2;
    for (var usuario in usuarios) {
      if (usuario == userName) {
        if (await sheet?.values.value(row: idCont, column: 5) == password) {
          //print('contrasena OK');
          //print(idCont.toString() +"este id es el de la izquierda del excel no del usuario");
          return Future<bool>.value(true);
        } else {
          //print('contrasena NOT OK');
          //print(idCont.toString() +"  este id es el de la izquierda del excel no del usuario");
          return Future<bool>.value(false);
        }
      }
      idCont += 1;
    }
  } else {
    //print('El usuario NO existe'); // se retorna error de inicio de sesion en pantalla
    return Future<bool>.value(false);
  }
}

// ignore: body_might_complete_normally_nullable, non_constant_identifier_names
Future<bool?> getRol(String userName) async {
  //print(userName + password);
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  final sheet = ss.worksheetByTitle('Usuarios');

  // se almacenan todos los nombres de usuario en una lista
  var usuarios = await sheet?.values.column(4, fromRow: 2);

  var idCont = 2;
  for (var usuario in usuarios!) {
    if (usuario == userName) {
      if (await sheet?.values.value(row: idCont, column: 6) == 'profesor') {
        return Future<bool>.value(true);
      } else {
        return Future<bool>.value(false);
      }
    }
    idCont += 1;
  }
}

// ignore: body_might_complete_normally_nullable, non_constant_identifier_names
Future<String?> getFullName(String userName) async {
  //print(userName + password);
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  final sheet = ss.worksheetByTitle('Usuarios');

  // se almacenan todos los nombres de usuario en una lista
  var usuarios = await sheet?.values.column(4, fromRow: 2);

  var idCont = 2;
  for (var usuario in usuarios!) {
    if (usuario == userName) {
      var name = await sheet?.values.value(row: idCont, column: 2);
      var stringName = name.toString();
      var lastName = await sheet?.values.value(row: idCont, column: 3);
      var stringLastName = lastName.toString();

      return "$stringName $stringLastName";
    }
    idCont += 1;
  }
}

//devuelve true o false si existe o no un estudiante en una seccion especifica de septimo
//En caso de existir el estudiante guarda su informacion en una lista
Future<bool?> studentExist7th(String studentName, String studentSection) async {
  //reset de la informacion del estudiante
  studentInformation = [];
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  final sheet = ss.worksheetByTitle('Septimo');

  //auxiliar aca porque es global para septimos
  var auxiliar = await sheet?.values.value(column: 2, row: 2);
  //print(auxiliar.toString());
  if (studentSection == "7-1") {
    // se almacenan los estudiantes de la seccion 7-1 en la variable students
    var students = await sheet?.values.column(3, fromRow: 9, length: 40);

    var idCont = 9;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-1");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-2") {
    // se almacenan los estudiantes de la seccion 7-2 en la variable students
    var students = await sheet?.values.column(3, fromRow: 55, length: 40);

    var idCont = 55;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-2");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-3") {
    // se almacenan los estudiantes de la seccion 7-3 en la variable students
    var students = await sheet?.values.column(3, fromRow: 101, length: 40);

    var idCont = 101;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-3");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-4") {
    // se almacenan los estudiantes de la seccion 7-4 en la variable students
    var students = await sheet?.values.column(3, fromRow: 147, length: 40);

    var idCont = 147;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-4");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-5") {
    // se almacenan los estudiantes de la seccion 7-5 en la variable students
    var students = await sheet?.values.column(3, fromRow: 193, length: 40);

    var idCont = 193;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-5");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-6") {
    // se almacenan los estudiantes de la seccion 7-6 en la variable students
    var students = await sheet?.values.column(3, fromRow: 239, length: 40);

    var idCont = 239;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-6");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-7") {
    // se almacenan los estudiantes de la seccion 7-7 en la variable students
    var students = await sheet?.values.column(3, fromRow: 285, length: 40);

    var idCont = 285;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-7");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-8") {
    // se almacenan los estudiantes de la seccion 7-8 en la variable students
    var students = await sheet?.values.column(3, fromRow: 331, length: 40);

    var idCont = 331;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-8");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-9") {
    // se almacenan los estudiantes de la seccion 7-9 en la variable students
    var students = await sheet?.values.column(3, fromRow: 377, length: 40);

    var idCont = 377;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-9");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-10") {
    // se almacenan los estudiantes de la seccion 7-10 en la variable students
    var students = await sheet?.values.column(3, fromRow: 423, length: 40);

    var idCont = 423;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-10");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-11") {
    // se almacenan los estudiantes de la seccion 7-11 en la variable students
    var students = await sheet?.values.column(3, fromRow: 469, length: 40);

    var idCont = 469;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-11");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-12") {
    // se almacenan los estudiantes de la seccion 7-12 en la variable students
    var students = await sheet?.values.column(3, fromRow: 515, length: 40);

    var idCont = 515;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-12");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-13") {
    // se almacenan los estudiantes de la seccion 7-13 en la variable students
    var students = await sheet?.values.column(3, fromRow: 561, length: 40);

    var idCont = 561;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-13");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-14") {
    // se almacenan los estudiantes de la seccion 7-14 en la variable students
    var students = await sheet?.values.column(3, fromRow: 607, length: 40);

    var idCont = 607;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-14");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "7-15") {
    // se almacenan los estudiantes de la seccion 7-15 en la variable students
    var students = await sheet?.values.column(3, fromRow: 653, length: 40);

    var idCont = 653;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Séptimo");
        studentInformation.add("7-15");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else {
    return Future<bool>.value(false);
  }
}

//devuelve true o false si existe o no un estudiante en una seccion especifica de octavo
//En caso de existir el estudiante guarda su informacion en una lista
Future<bool?> studentExist8th(String studentName, String studentSection) async {
  //reset de la informacion del estudiante
  studentInformation = [];
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  final sheet = ss.worksheetByTitle('Octavo');

  //auxiliar aca porque es global para septimos
  var auxiliar = await sheet?.values.value(column: 2, row: 2);
  //print(auxiliar.toString());
  if (studentSection == "8-1") {
    // se almacenan los estudiantes de la seccion 8-1 en la variable students
    var students = await sheet?.values.column(3, fromRow: 9, length: 40);

    var idCont = 9;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-1");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "8-2") {
    // se almacenan los estudiantes de la seccion 8-2 en la variable students
    var students = await sheet?.values.column(3, fromRow: 55, length: 40);

    var idCont = 55;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-2");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "8-3") {
    // se almacenan los estudiantes de la seccion 8-3 en la variable students
    var students = await sheet?.values.column(3, fromRow: 101, length: 40);

    var idCont = 101;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-3");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "8-4") {
    // se almacenan los estudiantes de la seccion 8-4 en la variable students
    var students = await sheet?.values.column(3, fromRow: 147, length: 40);

    var idCont = 147;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-4");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }
    return Future<bool>.value(false);
  } else if (studentSection == "8-5") {
    // se almacenan los estudiantes de la seccion 8-5 en la variable students
    var students = await sheet?.values.column(3, fromRow: 193, length: 40);

    var idCont = 193;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-5");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "8-6") {
    // se almacenan los estudiantes de la seccion 8-6 en la variable students
    var students = await sheet?.values.column(3, fromRow: 239, length: 40);

    var idCont = 239;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-6");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "8-7") {
    // se almacenan los estudiantes de la seccion 8-7 en la variable students
    var students = await sheet?.values.column(3, fromRow: 285, length: 40);

    var idCont = 285;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-7");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "8-8") {
    // se almacenan los estudiantes de la seccion 8-8 en la variable students
    var students = await sheet?.values.column(3, fromRow: 331, length: 40);

    var idCont = 331;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-8");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "8-9") {
    // se almacenan los estudiantes de la seccion 8-9 en la variable students
    var students = await sheet?.values.column(3, fromRow: 377, length: 40);

    var idCont = 377;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-9");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "8-10") {
    // se almacenan los estudiantes de la seccion 8-10 en la variable students
    var students = await sheet?.values.column(3, fromRow: 423, length: 40);

    var idCont = 423;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-10");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "8-11") {
    // se almacenan los estudiantes de la seccion 8-11 en la variable students
    var students = await sheet?.values.column(3, fromRow: 469, length: 40);

    var idCont = 469;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-11");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "8-12") {
    // se almacenan los estudiantes de la seccion 8-12 en la variable students
    var students = await sheet?.values.column(3, fromRow: 515, length: 40);

    var idCont = 515;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-12");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "8-13") {
    // se almacenan los estudiantes de la seccion 8-13 en la variable students
    var students = await sheet?.values.column(3, fromRow: 561, length: 40);

    var idCont = 561;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-13");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "8-14") {
    // se almacenan los estudiantes de la seccion 8-14 en la variable students
    var students = await sheet?.values.column(3, fromRow: 607, length: 40);

    var idCont = 607;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-14");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "8-15") {
    // se almacenan los estudiantes de la seccion 8-15 en la variable students
    var students = await sheet?.values.column(3, fromRow: 653, length: 40);

    var idCont = 653;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Octavo");
        studentInformation.add("8-15");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else {
    return Future<bool>.value(false);
  }
}

//devuelve true o false si existe o no un estudiante en una seccion especifica de noveno
//En caso de existir el estudiante guarda su informacion en una lista
Future<bool?> studentExist9th(String studentName, String studentSection) async {
  //reset de la informacion del estudiante
  studentInformation = [];
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  final sheet = ss.worksheetByTitle('Noveno');

  //auxiliar aca porque es global para septimos
  var auxiliar = await sheet?.values.value(column: 2, row: 2);
  //print(auxiliar.toString());
  if (studentSection == "9-1") {
    // se almacenan los estudiantes de la seccion 9-1 en la variable students
    var students = await sheet?.values.column(3, fromRow: 9, length: 40);

    var idCont = 9;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-1");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-2") {
    // se almacenan los estudiantes de la seccion 9-2 en la variable students
    var students = await sheet?.values.column(3, fromRow: 55, length: 40);

    var idCont = 55;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-2");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-3") {
    // se almacenan los estudiantes de la seccion 9-3 en la variable students
    var students = await sheet?.values.column(3, fromRow: 101, length: 40);

    var idCont = 101;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-3");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-4") {
    // se almacenan los estudiantes de la seccion 9-4 en la variable students
    var students = await sheet?.values.column(3, fromRow: 147, length: 40);

    var idCont = 147;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-4");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-5") {
    // se almacenan los estudiantes de la seccion 9-5 en la variable students
    var students = await sheet?.values.column(3, fromRow: 193, length: 40);

    var idCont = 193;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-5");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-6") {
    // se almacenan los estudiantes de la seccion 9-6 en la variable students
    var students = await sheet?.values.column(3, fromRow: 239, length: 40);

    var idCont = 239;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-6");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-7") {
    // se almacenan los estudiantes de la seccion 9-7 en la variable students
    var students = await sheet?.values.column(3, fromRow: 285, length: 40);

    var idCont = 285;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-7");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-8") {
    // se almacenan los estudiantes de la seccion 9-8 en la variable students
    var students = await sheet?.values.column(3, fromRow: 331, length: 40);

    var idCont = 331;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-8");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-9") {
    // se almacenan los estudiantes de la seccion 9-9 en la variable students
    var students = await sheet?.values.column(3, fromRow: 377, length: 40);

    var idCont = 377;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-9");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-10") {
    // se almacenan los estudiantes de la seccion 9-10 en la variable students
    var students = await sheet?.values.column(3, fromRow: 423, length: 40);

    var idCont = 423;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-10");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-11") {
    // se almacenan los estudiantes de la seccion 9-11 en la variable students
    var students = await sheet?.values.column(3, fromRow: 469, length: 40);

    var idCont = 469;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-11");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-12") {
    // se almacenan los estudiantes de la seccion 9-12 en la variable students
    var students = await sheet?.values.column(3, fromRow: 515, length: 40);

    var idCont = 515;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-12");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());
        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-13") {
    // se almacenan los estudiantes de la seccion 9-13 en la variable students
    var students = await sheet?.values.column(3, fromRow: 561, length: 40);

    var idCont = 561;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-13");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-14") {
    // se almacenan los estudiantes de la seccion 9-14 en la variable students
    var students = await sheet?.values.column(3, fromRow: 607, length: 40);

    var idCont = 607;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-14");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "9-15") {
    // se almacenan los estudiantes de la seccion 9-15 en la variable students
    var students = await sheet?.values.column(3, fromRow: 653, length: 40);

    var idCont = 653;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Noveno");
        studentInformation.add("9-15");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else {
    return Future<bool>.value(false);
  }
}

//devuelve true o false si existe o no un estudiante en una seccion especifica de decimo
//En caso de existir el estudiante guarda su informacion en una lista
Future<bool?> studentExist10th(
    String studentName, String studentSection) async {
  //reset de la informacion del estudiante
  studentInformation = [];
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  final sheet = ss.worksheetByTitle('Decimo');

  //auxiliar aca porque es global para septimos
  var auxiliar = await sheet?.values.value(column: 2, row: 2);
  //print(auxiliar.toString());
  if (studentSection == "10-1") {
    // se almacenan los estudiantes de la seccion 10-1 en la variable students
    var students = await sheet?.values.column(3, fromRow: 9, length: 40);

    var idCont = 9;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-1");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-2") {
    // se almacenan los estudiantes de la seccion 10-2 en la variable students
    var students = await sheet?.values.column(3, fromRow: 55, length: 40);

    var idCont = 55;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-2");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-3") {
    // se almacenan los estudiantes de la seccion 10-3 en la variable students
    var students = await sheet?.values.column(3, fromRow: 101, length: 40);

    var idCont = 101;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-3");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-4") {
    // se almacenan los estudiantes de la seccion 10-4 en la variable students
    var students = await sheet?.values.column(3, fromRow: 147, length: 40);

    var idCont = 147;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-4");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-5") {
    // se almacenan los estudiantes de la seccion 10-5 en la variable students
    var students = await sheet?.values.column(3, fromRow: 193, length: 40);

    var idCont = 193;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-5");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-6") {
    // se almacenan los estudiantes de la seccion 10-6 en la variable students
    var students = await sheet?.values.column(3, fromRow: 239, length: 40);

    var idCont = 239;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-6");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-7") {
    // se almacenan los estudiantes de la seccion 10-7 en la variable students
    var students = await sheet?.values.column(3, fromRow: 285, length: 40);

    var idCont = 285;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-7");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-8") {
    // se almacenan los estudiantes de la seccion 10-8 en la variable students
    var students = await sheet?.values.column(3, fromRow: 331, length: 40);

    var idCont = 331;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-8");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-9") {
    // se almacenan los estudiantes de la seccion 10-9 en la variable students
    var students = await sheet?.values.column(3, fromRow: 377, length: 40);

    var idCont = 377;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-9");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-10") {
    // se almacenan los estudiantes de la seccion 10-10 en la variable students
    var students = await sheet?.values.column(3, fromRow: 423, length: 40);

    var idCont = 423;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-10");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-11") {
    // se almacenan los estudiantes de la seccion 10-11 en la variable students
    var students = await sheet?.values.column(3, fromRow: 469, length: 40);

    var idCont = 469;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-11");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-12") {
    // se almacenan los estudiantes de la seccion 10-12 en la variable students
    var students = await sheet?.values.column(3, fromRow: 515, length: 40);

    var idCont = 515;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-12");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-13") {
    // se almacenan los estudiantes de la seccion 10-13 en la variable students
    var students = await sheet?.values.column(3, fromRow: 561, length: 40);

    var idCont = 561;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-13");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-14") {
    // se almacenan los estudiantes de la seccion 10-14 en la variable students
    var students = await sheet?.values.column(3, fromRow: 607, length: 40);

    var idCont = 607;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-14");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "10-15") {
    // se almacenan los estudiantes de la seccion 10-15 en la variable students
    var students = await sheet?.values.column(3, fromRow: 653, length: 40);

    var idCont = 653;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Décimo");
        studentInformation.add("10-15");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else {
    return Future<bool>.value(false);
  }
}

//devuelve true o false si existe o no un estudiante en una seccion especifica de undecimo
//En caso de existir el estudiante guarda su informacion en una lista
Future<bool?> studentExist11th(
    String studentName, String studentSection) async {
  //reset de la informacion del estudiante
  studentInformation = [];
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  final sheet = ss.worksheetByTitle('Undecimo');

  //auxiliar aca porque es global para septimos
  var auxiliar = await sheet?.values.value(column: 2, row: 2);
  //print(auxiliar.toString());
  if (studentSection == "11-1") {
    // se almacenan los estudiantes de la seccion 11-1 en la variable students
    var students = await sheet?.values.column(3, fromRow: 9, length: 40);

    var idCont = 9;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-1");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-2") {
    // se almacenan los estudiantes de la seccion 11-2 en la variable students
    var students = await sheet?.values.column(3, fromRow: 55, length: 40);

    var idCont = 55;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-2");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-3") {
    // se almacenan los estudiantes de la seccion 11-3 en la variable students
    var students = await sheet?.values.column(3, fromRow: 101, length: 40);

    var idCont = 101;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-3");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-4") {
    // se almacenan los estudiantes de la seccion 11-4 en la variable students
    var students = await sheet?.values.column(3, fromRow: 147, length: 40);

    var idCont = 147;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-4");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-5") {
    // se almacenan los estudiantes de la seccion 11-5 en la variable students
    var students = await sheet?.values.column(3, fromRow: 193, length: 40);

    var idCont = 193;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-5");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-6") {
    // se almacenan los estudiantes de la seccion 11-6 en la variable students
    var students = await sheet?.values.column(3, fromRow: 239, length: 40);

    var idCont = 239;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-6");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-7") {
    // se almacenan los estudiantes de la seccion 11-7 en la variable students
    var students = await sheet?.values.column(3, fromRow: 285, length: 40);

    var idCont = 285;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-7");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-8") {
    // se almacenan los estudiantes de la seccion 11-8 en la variable students
    var students = await sheet?.values.column(3, fromRow: 331, length: 40);

    var idCont = 331;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-8");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-9") {
    // se almacenan los estudiantes de la seccion 11-9 en la variable students
    var students = await sheet?.values.column(3, fromRow: 377, length: 40);

    var idCont = 377;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-9");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-10") {
    // se almacenan los estudiantes de la seccion 11-10 en la variable students
    var students = await sheet?.values.column(3, fromRow: 423, length: 40);

    var idCont = 423;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-10");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-11") {
    // se almacenan los estudiantes de la seccion 11-11 en la variable students
    var students = await sheet?.values.column(3, fromRow: 469, length: 40);

    var idCont = 469;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-11");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-12") {
    // se almacenan los estudiantes de la seccion 11-12 en la variable students
    var students = await sheet?.values.column(3, fromRow: 515, length: 40);

    var idCont = 515;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-12");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-13") {
    // se almacenan los estudiantes de la seccion 11-13 en la variable students
    var students = await sheet?.values.column(3, fromRow: 561, length: 40);

    var idCont = 561;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-13");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-14") {
    // se almacenan los estudiantes de la seccion 11-14 en la variable students
    var students = await sheet?.values.column(3, fromRow: 607, length: 40);

    var idCont = 607;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-14");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "11-15") {
    // se almacenan los estudiantes de la seccion 11-15 en la variable students
    var students = await sheet?.values.column(3, fromRow: 653, length: 40);

    var idCont = 653;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Undécimo");
        studentInformation.add("11-15");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else {
    return Future<bool>.value(false);
  }
}

//devuelve true o false si existe o no un estudiante en una seccion especifica de duodecimo
//En caso de existir el estudiante guarda su informacion en una lista
Future<bool?> studentExist12th(
    String studentName, String studentSection) async {
  //reset de la informacion del estudiante
  studentInformation = [];
  // init GSheets
  final gsheets = GSheets(_credentials);
  // fetch spreadsheet by its id
  final ss = await gsheets.spreadsheet(_spreadsheetId);
  // get worksheet by its title
  final sheet = ss.worksheetByTitle('Duodecimo');

  //auxiliar aca porque es global para septimos
  var auxiliar = await sheet?.values.value(column: 2, row: 2);
  //print(auxiliar.toString());
  if (studentSection == "12-1") {
    // se almacenan los estudiantes de la seccion 12-1 en la variable students
    var students = await sheet?.values.column(3, fromRow: 9, length: 40);

    var idCont = 9;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Duodécimo");
        studentInformation.add("12-1");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "12-2") {
    // se almacenan los estudiantes de la seccion 12-2 en la variable students
    var students = await sheet?.values.column(3, fromRow: 55, length: 40);

    var idCont = 55;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Duodécimo");
        studentInformation.add("12-2");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "12-3") {
    // se almacenan los estudiantes de la seccion 12-3 en la variable students
    var students = await sheet?.values.column(3, fromRow: 101, length: 40);

    var idCont = 101;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Duodécimo");
        studentInformation.add("12-3");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "12-4") {
    // se almacenan los estudiantes de la seccion 12-4 en la variable students
    var students = await sheet?.values.column(3, fromRow: 147, length: 40);

    var idCont = 147;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Duodécimo");
        studentInformation.add("12-4");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else if (studentSection == "12-5") {
    // se almacenan los estudiantes de la seccion 12-5 en la variable students
    var students = await sheet?.values.column(3, fromRow: 193, length: 40);

    var idCont = 193;
    for (var student in students!) {
      if (student == studentName) {
        var studentName = await sheet?.values.value(column: 3, row: idCont);
        studentInformation.add(studentName.toString());
        studentInformation.add("Duodécimo");
        studentInformation.add("12-5");
        studentInformation.add(auxiliar.toString());
        var studentOrientador = await sheet?.values.value(column: 2, row: 5);
        studentInformation.add(studentOrientador.toString());
        var studentProfGuia = await sheet?.values.value(column: 2, row: 6);
        studentInformation.add(studentProfGuia.toString());
        var studentTutorName =
            await sheet?.values.value(column: 5, row: idCont);
        studentInformation.add(studentTutorName.toString());
        var studentTutorEmail =
            await sheet?.values.value(column: 6, row: idCont);
        studentInformation.add(studentTutorEmail.toString());
        var studentTutorNumber =
            await sheet?.values.value(column: 7, row: idCont);
        studentInformation.add(studentTutorNumber.toString());
        var studentStatus = await sheet?.values.value(column: 8, row: idCont);
        studentInformation.add(studentStatus.toString());

        return Future<bool>.value(true);
      }
      idCont = idCont + 1;
    }

    return Future<bool>.value(false);
  } else {
    return Future<bool>.value(false);
  }
}
