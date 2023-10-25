import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class FadeAnimation extends StatelessWidget {
  final double delay; // Controla el retraso de la animación.
  final Widget child; // El widget que se animará.

  // Constructor de la clase con los parámetros `delay` y `child`.
  const FadeAnimation(this.delay, this.child, {super.key});

  @override
  Widget build(BuildContext context) {
    // Se define un tween que especifica cómo se realizará la animación.
    final tween = MovieTween()
      ..tween('opacity',
          Tween(begin: 0.0, end: 1.0), // Cambio de opacidad de 0 a 1.
          duration: const Duration(
              milliseconds: 500), // Duración de la animación (medio segundo).
          curve:
              Curves.easeIn) // La curva de la animación (comienza lentamente).
      ..tween(
          'translateY',
          duration: const Duration(milliseconds: 500),
          Tween(
              begin: -30.0,
              end: 0.0), // Cambio en la posición vertical de -30 a 0.
          curve:
              Curves.easeOut); // La curva de la animación (termina lentamente).

    return CustomAnimationBuilder(
        delay: Duration(
            milliseconds: (500 * delay).round()), // Aplicación del retraso.
        duration: tween.duration, // Duración basada en el tween.
        tween: tween, // El tween definido previamente.
        child: child, // El widget hijo que se animará.
        builder: (BuildContext context, Movie value, Widget? child) {
          // Se construye el widget animado.
          return Opacity(
              opacity: value.get("opacity"), // Se ajusta la opacidad.
              child: Transform.translate(
                  offset: Offset(0.0, value.get("translateY")),
                  child: child)); // Se ajusta la posición vertical.
        });
  }
}
