import 'package:flutter/material.dart';

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
        title: Text('Pagina Principal'),
      ),
      body: const Center(
        child: Text('Hola Mundo Administrador'),
      ),
    );
  }
}
