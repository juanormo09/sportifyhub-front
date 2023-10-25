// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:sportifyhub_front/animations/fadeanimation.dart';
import 'package:sportifyhub_front/api/authentication_api.dart';
import 'package:sportifyhub_front/helpers/http_response.dart';
import 'package:sportifyhub_front/utils/alertdialog.dart';
import 'package:sportifyhub_front/widgets/textfield.dart';
import 'package:sportifyhub_front/views/principal_home.dart';

class SingUpPage extends StatefulWidget {
  const SingUpPage({super.key});

  @override
  State<SingUpPage> createState() => _SingUpPageState();
}

class _SingUpPageState extends State<SingUpPage> {
  final AuthenticationApi authenticationApi = AuthenticationApi();

  final Logger _logger = Logger();

  // Controladores para los campos de entrada (username, email y password)
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Función para registrar un usuario al presionar el botón "Sing Up"
  Future<void> registerUser() async {
    final username = usernameController.text;
    final email = emailController.text;
    final phone = phoneController.text;
    final password = passwordController.text;

    ProgressDialog.show(context); // Muestra un indicador de progreso

    final HttpResponse response = await authenticationApi.register(
      username: username,
      email: email,
      phone: phone,
      password: password,
    );

    ProgressDialog.dissmiss(context); // Oculta el indicador de progreso

    if (response.data != null) {
      // Registro exitoso, muestra información y navega a la página principal
      _logger.i('Registro exitoso ${response.data}');
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PrincipalHomePage(),
        ),
      );
    } else {
      // Error de registro, muestra información de error en un diálogo
      _logger.e("Error de registro ${response.error.statusCode}");
      _logger.e("Error de registro ${response.error.message}");
      _logger.e("Error de registro ${response.error.data}");

      Dialogs.alert(context,
          title: "Error", description: response.error.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Permite que la pantalla se desplace al mostrar el teclado
      backgroundColor: Colors.white, // Fondo blanco
      appBar: AppBar(
        elevation: 0,
        backgroundColor:
            Colors.white, // Color de fondo de la barra de aplicación
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
                context); // Botón de retroceso que cierra la página de registro
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Container(
          height: MediaQuery.of(context).size.height -
              50, // Altura relativa a la pantalla
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(
                    1,
                    const Text(
                      'Sing Up',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  FadeAnimation(
                    1.2,
                    Text(
                      'Crea una cuenta, es gratis!!',
                      style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                    ),
                  )
                ],
              ),
              Column(
                children: <Widget>[
                  // Campos de entrada de texto para username, email y password
                  FadeAnimation(
                    1.2,
                    textField(
                      label: 'username',
                      controller: usernameController,
                    ),
                  ),
                  FadeAnimation(
                    1.3,
                    textField(
                      label: 'Correo Electronico',
                      controller: emailController,
                    ),
                  ),
                  FadeAnimation(
                    1.4,
                    textField(
                      label: 'Telefono',
                      controller: phoneController,
                    ),
                  ),
                  FadeAnimation(
                    1.5,
                    textField(
                      label: 'Contraseña',
                      obscureText: true,
                      controller: passwordController,
                    ),
                  ),
                ],
              ),
              FadeAnimation(
                1.6,
                Container(
                  padding: const EdgeInsets.only(top: 3, left: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: const Border(
                      bottom: BorderSide(color: Colors.black),
                      left: BorderSide(color: Colors.black),
                      right: BorderSide(color: Colors.black),
                      top: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      registerUser(); // Llama a la función registerUser al presionar el botón "Sing Up"
                    },
                    color: Colors.greenAccent, // Color de fondo del botón
                    elevation: 5, // Sombra
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(50), // Borde redondeado
                    ),
                    child: const Text(
                      'Registrase',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ),
              ),
              const FadeAnimation(
                1.7,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'Ya tienes una cuenta?'), // Mensaje "Ya tienes una cuenta"
                    Text(
                      'Inicia Sesión',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
