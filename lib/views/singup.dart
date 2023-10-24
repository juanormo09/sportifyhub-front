import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sportifyhub_front/animations/fadeanimation.dart';
import 'package:sportifyhub_front/widgets/textfield.dart';

class SingUpPage extends StatelessWidget {
  SingUpPage({super.key});

  // Controladores para los campos de entrada (username, email y password)
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Función para registrar un usuario al presionar el botón "Sing Up"
  Future<void> registerUser() async {
    final username = usernameController.text;
    final email = emailController.text;
    final password = passwordController.text;

    final response = await http.post(
      Uri.parse(
          'http://10.0.2.2:8000/api/auth/register'), // Realiza una solicitud POST a la URL de registro
      body: {
        'username': username,
        'email': email,
        'password': password,
      },
    );

    if (response.statusCode == 201) {
      // Registro exitoso
      // Puedes procesar la respuesta aquí
      print('Registro exitoso');
    } else {
      // Error en el registro
      // Puedes manejar el error aquí
      print('Error en el registro');
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
            Navigator.pop(context);
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
                      'crea una cuenta, es gratis',
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
                          label: 'username', controller: usernameController)),
                  FadeAnimation(1.3,
                      textField(label: 'email', controller: emailController)),
                  FadeAnimation(
                      1.5,
                      textField(
                          label: 'Contraseña',
                          obscureText: true,
                          controller: passwordController)),
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
                      'Sing Up',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
                    ),
                  ),
                ),
              ),
              FadeAnimation(
                1.7,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'already have an account?'), // Mensaje "Ya tienes una cuenta"
                    Text(
                      'Login',
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
