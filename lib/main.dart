import 'package:flutter/material.dart';
import 'package:sportifyhub_front/animations/fadeanimation.dart';
import 'package:sportifyhub_front/views/login.dart';
import 'package:sportifyhub_front/views/singup.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          false, // Oculta la marca de depuración en la esquina
      title: 'Material App',
      theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light, //
          colorSchemeSeed: Colors.white),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(
              horizontal: 30, vertical: 50), // Margen interno
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Sección de bienvenida
              Column(
                children: <Widget>[
                  FadeAnimation(
                    1,
                    const Text(
                      "Bienvenido",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20, // Espacio vertical entre elementos
                  ),
                  FadeAnimation(
                    1.2,
                    Text(
                      'automatic identity verification witch enables you to verify your identity',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.grey[700], // Color de texto gris
                        fontSize: 15,
                      ),
                    ),
                  )
                ],
              ),
              // Sección de imagen de fondo
              FadeAnimation(
                1.4,
                Container(
                  height: MediaQuery.of(context).size.height /
                      3, // Altura relativa a la pantalla
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/ilustracion.jpeg'), // Carga la imagen de fondo
                    ),
                  ),
                ),
              ),
              // Sección de botones
              Column(
                children: <Widget>[
                  FadeAnimation(
                    1.5,
                    MaterialButton(
                      minWidth: double.infinity, // Ancho completo
                      height: 60, // Altura del botón
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    LoginPage())); // Navega a la página de inicio de sesión
                      },
                      elevation: 5, // Sombra
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black), // Borde negro
                        borderRadius:
                            BorderRadius.circular(50), // Borde redondeado
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18), // Estilo del texto
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20, // Espacio vertical entre elementos
                  ),
                  FadeAnimation(
                    1.6,
                    Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      decoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(50), // Borde redondeado
                        border: const Border(
                          bottom: BorderSide(color: Colors.black),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black),
                          top: BorderSide(color: Colors.black),
                        ),
                      ),
                      child: MaterialButton(
                        minWidth: double.infinity, // Ancho completo
                        height: 60, // Altura del botón
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SingUpPage())); // Navega a la página de registro
                        },
                        color: Colors.yellow, // Color de fondo del botón
                        elevation: 5, // Sombra
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(50), // Borde redondeado
                        ),
                        child: const Text(
                          'register',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18), // Estilo del texto
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
