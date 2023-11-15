// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'dart:convert';
import 'package:sportifyhub_front/animations/fadeanimation.dart';
import 'package:sportifyhub_front/api/authentication_api.dart';
import 'package:sportifyhub_front/helpers/http_response.dart';
import 'package:sportifyhub_front/utils/alertdialog.dart';
import 'package:sportifyhub_front/views/Administrador_page.dart';
import 'package:sportifyhub_front/views/principal_home.dart';
import 'package:sportifyhub_front/widgets/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final AuthenticationApi authenticationApi = AuthenticationApi();

  final Logger _logger = Logger();

  // Controladores para los campos de entrada (username y password)
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> loginUser() async {
    final username = usernameController.text;
    final password = passwordController.text;

    ProgressDialog.show(context); // Muestra un indicador de progreso

    final HttpResponse response = await authenticationApi.login(
      username: username,
      password: password,
    );

    ProgressDialog.dissmiss(context); // Oculta el indicador de progreso

    if (response.data != null) {
      handleSuccessfulLogin(response);
    } else {
      handleLoginError(response);
    }
  }

  void handleSuccessfulLogin(HttpResponse response) {
    String accessToken = response.data['access'];
    final payloadMap = decodeToken(accessToken);
    navigateBasedOnRole(payloadMap);
  }

  Map<String, dynamic> decodeToken(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Token inválido');
    }

    final String normalized = base64Url.normalize(parts[1]);
    final resp = utf8.decode(base64Url.decode(normalized));
    return json.decode(resp);
  }

  void navigateBasedOnRole(Map<String, dynamic> payloadMap) {
    if (payloadMap.containsKey('rol_title')) {
      String rolTitle = payloadMap['rol_title'];
      if (rolTitle == 'Administrador') {
        navigateToPage(const AdminsitradorPage());
      } else {
        navigateToPage(const PrincipalHomePage());
      }
    } else {
      navigateToPage(const PrincipalHomePage());
    }
  }

  void navigateToPage(Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  void handleLoginError(HttpResponse response) {
    _logger.e("Error de inicio de sesión ${response.error.statusCode}");
    _logger.e("Error de inicio de sesión ${response.error.message}");
    _logger.e("Error de inicio de sesión ${response.error.data}");

    Dialogs.alert(context, title: "Error", description: response.error.message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          false, // Evita que el teclado haga que la pantalla se desplace
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(
                context); // Botón de retroceso que cierra la página de inicio de sesión
          },
          icon: const Icon(
            Icons.arrow_back_ios_new,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      const FadeAnimation(
                        1,
                        Text(
                          'Login',
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
                          'Inicia Sesión en tu cuenta',
                          style:
                              TextStyle(fontSize: 15, color: Colors.grey[700]),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: <Widget>[
                        FadeAnimation(
                            1.2,
                            textField(
                              label: 'Username',
                              controller: usernameController,
                            )),
                        FadeAnimation(
                            1.3,
                            textField(
                              label: 'Contraseña',
                              obscureText: true,
                              controller: passwordController,
                            )),
                      ],
                    ),
                  ),
                  FadeAnimation(
                    1.4,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
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
                            loginUser(); // Llama a la función loginUser al presionar el botón "Login"
                          },
                          color: Colors.greenAccent, // Color de fondo del botón
                          elevation: 5, // Sombra
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(50), // Borde redondeado
                          ),
                          child: const Text(
                            'Iniciar Sesión',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18), // Estilo del texto
                          ),
                        ),
                      ),
                    ),
                  ),
                  const FadeAnimation(
                    1.5,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                            '¿No tienes una cuenta?'), // Mensaje "¿No tienes una cuenta?"
                        Text(
                          'Registrate',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            FadeAnimation(
              1.2,
              Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(
                        'assets/ilustracion.jpeg'), // Imagen de fondo
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
