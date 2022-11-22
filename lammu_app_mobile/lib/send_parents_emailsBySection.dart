import 'package:flutter/material.dart';
import 'package:lammu_app/admin_page.dart';
import 'read_google_sheets.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
// ignore: use_key_in_widget_constructors
class SendSectionParentsEmails extends StatefulWidget {
  //static String id = 'login_page';
  //static String? fullName = _RedactParentEmailState()._userNameController.text;
  @override
  State<SendSectionParentsEmails> createState() => _SendSectionParentsEmailsState();
}

class _SendSectionParentsEmailsState extends State<SendSectionParentsEmails> {
  bool isButtonPressed = false;

  // text controllers
  final _asuntoController = TextEditingController();
  final _emailTextController = TextEditingController();

  void buttonPressed() {
    setState(() {
      if (isButtonPressed == false) {
        isButtonPressed = true;
      } else if (isButtonPressed == true) {
        isButtonPressed = false;
      }
    });
  }

  Future verificationB4SendEmail() async {
    if (_emailTextController.text.isEmpty ||
        _asuntoController.text.isEmpty) {
      _DataErrorDialog(context);
    } else {
      exitDialog();
    }
  }


  Future sendEmail() async {

    final Email email = Email(
      body: _emailTextController.text,
      subject: _asuntoController.text,
      //recipients: ['joansc16@gmail.com','joansctec@gmail.com','lammuapp@gmail.com'],
      //recipients: getAllParentsEmails(),
      //cc: [''],
      bcc: getAllParentsEmails(),
      //attachmentPaths: [''],
      isHTML: false,
    );

    await FlutterEmailSender.send(email);
  }

  Future<dynamic> exitDialog() {
    return showDialog(context: context, barrierDismissible: false, builder: (context) => AlertDialog(
      title: const Text('Seguro(a) que desea enviar el comunicado?', style: TextStyle(
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
          MaterialPageRoute(builder: (context) => const AdminPage());

          // ignore: use_build_context_synchronously
          Navigator.push(context, route);

        }, child: const Text('SÍ',textAlign: TextAlign.right, style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.blue),),)
      ],
    ),);
  }


  @override
  void dispose() {
    _asuntoController.dispose();
    _emailTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('COMUNICADO')),
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
                  "Se enviará un correo electrónico a todos los padres de familia o tutores legales de la sección: $finalSection",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue[500]),
                ),
                const SizedBox(height: 40),

                Text(
                  "Ingrese el asunto del comunicado:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue[500]),
                ),

                const SizedBox(height: 20),

                //asunto textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _asuntoController,
                        //obscureText: _obscureText,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                Text(
                  "Ingrese el contenido del comunicado:",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.blue[500]),
                ),

                const SizedBox(height: 20),

                //body email textfield
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: TextField(
                        controller: _emailTextController,
                        keyboardType: TextInputType.multiline,
                        maxLines: 15,
                        textAlign: TextAlign.left,
                        style: const TextStyle(color: Colors.black),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                //boton de enviar comunicado
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 25,
                    vertical: 10,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: GestureDetector(
                      onTap: verificationB4SendEmail,
                      child: AnimatedContainer(
                        alignment: Alignment.center,
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(200),
                        ),
                        child: const Center(
                            child: Text(
                              "Enviar comunicado",
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}




// ignore: non_constant_identifier_names
void _DataErrorDialog(BuildContext context) {
  AlertDialog alert = const AlertDialog(
    title: Text(
      "Debe rellenar el asunto y el contenido del comunicado",
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