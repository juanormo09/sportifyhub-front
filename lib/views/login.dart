import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportifyhub_front/animations/fadeanimation.dart';
import 'package:sportifyhub_front/widgets/textfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  // Controladores para los campos de entrada (username y password)
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Función para iniciar sesión al presionar el botón "Login"
  Future<void> loginUser() async {
    final username = usernameController.text;
    final password = passwordController.text;

    final response = await http.post(
      Uri.parse(
          'http://127.0.0.1:8000/api/auth/login'), // Realiza una solicitud POST a la URL de inicio de sesión
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      // Registro exitoso
      print('Login exitoso');
    } else {
      // Error en el registro
      print('Error en el registro');
    }
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
            Navigator.pop(context);
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
                      FadeAnimation(
                        1,
                        const Text(
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
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18), // Estilo del texto
                          ),
                        ),
                      ),
                    ),
                  ),
                  FadeAnimation(
                    1.5,
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text('dont have an account?'),
                        Text(
                          'Sing Up',
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
                    image: AssetImage('assets/ilustracion.jpeg'),
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
