import 'package:flutter/material.dart';
import 'package:sportifyhub_front/main.dart';

class AdminsitradorPage extends StatefulWidget {
  const AdminsitradorPage({super.key});

 

  @override
  State<AdminsitradorPage> createState() => _AdministradorPageState();
}

class _AdministradorPageState extends State<AdminsitradorPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Pagina Principal Para acciones Del Usuario'),
        actions: [
          IconButton(
              onPressed: () => cerrarSesion(context),
              icon: const Icon(Icons.exit_to_app)),
        ],
      ),
      body: const Center(
        child: Text('Hola Mundo Administrador'),
      ),
    );
  }
  
   void cerrarSesion(BuildContext context) {
    // Lógica para cerrar sesión
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomePage()),
    );
  }
}
