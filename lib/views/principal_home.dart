import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:sportifyhub_front/infraestructure/models/establecimiento.dart';
import 'package:sportifyhub_front/main.dart';

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
      final response = await Dio().get(
          'https://sportybackenddjango.onrender.com/api/establecimiento/all');

      if (response.statusCode == 200) {
        if (response.data is List) {
          List<dynamic> data = response.data;
          setState(() {
            establecimientos =
                data.map((item) => Establecimiento.fromJson(item)).toList();
          });
        } else {
          print('Error: La respuesta no es una lista de establecimientos');
        }
      } else {
        print(
            'Error al obtener establecimientos. Código de estado: ${response.statusCode}');
      }
    } catch (e) {
      print('Error al obtener establecimientos: $e');
    }
  }

  void cerrarSesion(BuildContext context) {
    // Lógica para cerrar sesión
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Establecimientos'),
        actions: [
          IconButton(
              onPressed: () => cerrarSesion(context),
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (establecimientos != null && establecimientos!.isNotEmpty)
              for (var establecimiento in establecimientos!)
                Card(
                  margin: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Text(establecimiento.name),
                    subtitle: Text(establecimiento.direccion),
                    // Otras propiedades que deseas mostrar
                  ),
                ),
          ],
        ),
      ),
    );
  }
}