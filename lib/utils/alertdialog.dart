import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

abstract class Dialogs {
  // Método para mostrar un cuadro de diálogo de alerta
  static alert(
    BuildContext context, {
    required String title,
    required String description,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(title), // Establece el título del cuadro de diálogo
        content:
            Text(description), // Establece el contenido del cuadro de diálogo
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(_); // Cierra el cuadro de diálogo al presionar "OK"
            },
            child: const Text("OK"), // Etiqueta del botón "OK"
          )
        ],
      ),
    );
  }
}

abstract class ProgressDialog {
  // Método para mostrar un cuadro de diálogo de progreso
  static show(BuildContext context) {
    showCupertinoModalPopup(
        context: context,
        builder: (_) {
          return WillPopScope(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.white.withOpacity(0.7),
              child: Center(
                  child:
                      CircularProgressIndicator()), // Muestra un indicador de progreso
            ),
            onWillPop: () async => false,
          );
        });
  }

  // Método para cerrar el cuadro de diálogo de progreso
  static dissmiss(BuildContext context) {
    Navigator.of(context).pop();
  }
}
