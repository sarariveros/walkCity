import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -20,
            left: -10,
            width: 200,
            height: 200,
            child: Image.asset("assets/shape_01.png"),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Bienvenido a WalkCity!",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Que no queden lugares sin visitar",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Form(
                    child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          decoration: _buildDecoration(
                            hintText: 'Ingresa tu nombre',
                          ),
                          validator: (value) {
                            return (value != null && value.length >= 8)
                                ? null
                                : 'Debe tener minimo 8 caracteres';
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          autocorrect: false,
                          keyboardType: TextInputType.text,
                          decoration: _buildDecoration(
                            hintText: 'Ingresa tu correo',
                          ),
                          validator: (value) {
                            return (value != null && value.length >= 8)
                                ? null
                                : 'Debe tener minimo 8 caracteres';
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          autocorrect: false,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: _buildDecoration(
                            hintText: 'Ingresa tu contraseña',
                          ),
                          validator: (value) {
                            return (value != null && value.length >= 8)
                                ? null
                                : 'Debe tener minimo 8 caracteres';
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          style: const TextStyle(color: Colors.black),
                          autocorrect: false,
                          obscureText: true,
                          keyboardType: TextInputType.text,
                          decoration: _buildDecoration(
                            hintText: 'Confirma tu contraseña',
                          ),
                          validator: (value) {
                            return (value != null && value.length >= 8)
                                ? null
                                : 'Debe tener minimo 8 caracteres';
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        MaterialButton(
                          height: 60,
                          minWidth: double.infinity,
                          color: const Color.fromRGBO(228, 36, 36, .7),
                          child: const Text(
                            "Registrarse",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          onPressed: () {},
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const [
                            Text(
                              "¿Ya tienes una cuenta?",
                            ),
                            Text(
                              "Inicia sesion",
                              style: TextStyle(
                                  color: Color.fromRGBO(228, 36, 36, .7),
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  InputDecoration _buildDecoration({
    final String? hintText,
  }) {
    return InputDecoration(
      fillColor: const Color.fromARGB(255, 240, 240, 240),
      hintStyle: const TextStyle(color: Colors.grey),
      contentPadding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent)),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.transparent)),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
      hintText: hintText,
      filled: true,
    );
  }
}
