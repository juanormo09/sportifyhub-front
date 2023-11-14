import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sportifyhub_front/infraestructure/models/establecimiento.dart';

class PrincipalHomePage extends StatefulWidget {
  const PrincipalHomePage({super.key});

  @override
  State<PrincipalHomePage> createState() => _PrincipalHomePageState();
}

class _PrincipalHomePageState extends State<PrincipalHomePage> {
  List<Establecimiento>? establecimientos;

  @override
  void initState() {
    super.initState();
    getEstablecimientos();
  }

  Future<void> getEstablecimientos() async {
    try {
      final response =
          await Dio().get('http://127.0.0.1:8000/api/establecimiento/all');

      if (response.statusCode == 200) {
        // Si la respuesta es una lista, mapea cada elemento a un objeto Establecimiento
        if (response.data is List) {
          List<dynamic> data = response.data;
          establecimientos =
              data.map((item) => Establecimiento.fromJson(item)).toList();
        } else {
          // Manejo de error: La respuesta no es una lista
          print('Error: La respuesta no es una lista de establecimientos');
        }
      } else {
        // Manejo de error: La solicitud no fue exitosa
        print(
            'Error al obtener establecimientos. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      // Manejo de error en caso de que ocurra un problema con la solicitud
      print('Error al obtener establecimientos: $e');
    }
  }

  void cerrarSesion() {
    // Lógica para cerrar sesión
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Establecimientos'),
        actions: [
          IconButton(onPressed: cerrarSesion, icon: Icon(Icons.exit_to_app)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      ),
    );
  }
}
