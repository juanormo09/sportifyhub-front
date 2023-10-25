import 'package:flutter/material.dart';

class PrincipalHomePage extends StatefulWidget {
  const PrincipalHomePage({super.key});

  @override
  State<PrincipalHomePage> createState() => _PrincipalHomePageState();
}

class _PrincipalHomePageState extends State<PrincipalHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagina Principal'),
      ),
      body: const Center(
        child: Text('Hola Mundo'),
      ),
    );
  }
}
