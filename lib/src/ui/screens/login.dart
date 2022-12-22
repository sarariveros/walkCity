import 'package:flutter/material.dart';
import 'package:walkcity/src/routes/routes.dart';
import 'package:walkcity/src/providers/provider_login.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/services/service_auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Bienvenido",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                    ),
                    Image.asset("assets/shape_02.png"),
                    const SizedBox(
                      height: 30,
                    ),
                    ChangeNotifierProvider(
                      create: (context) => ProviderLogin(),
                      child: _LoginForm(),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "¿No tienes una cuenta?",
                        ),
                        MaterialButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, MyRoutes.rRegistro);
                          },
                          child: const Text(
                            "Registrate",
                            style: TextStyle(
                                color: Color.fromRGBO(228, 36, 36, .7),
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<_LoginForm> createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  bool _ispassword = true;

  void _viewPassword() {
    setState(() {
      _ispassword = !_ispassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<ProviderLogin>(context);
    return SizedBox(
      child: Form(
        key: loginProvider.formkey,
        child: Column(
          children: [
            TextFormField(
              style: const TextStyle(color: Colors.black),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: _buildDecoration(
                hintText: 'Ingresa tu correo',
              ),
              onChanged: (value) => loginProvider.email = value,
              validator: (value) {
                String caracteres =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

                RegExp regExp = RegExp(caracteres);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'No es un correo NO valido';
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              autocorrect: false,
              obscureText: _ispassword,
              keyboardType: TextInputType.text,
              decoration: _buildDecoration(
                hintText: 'Ingresa tu contraseña',
              ),
              onChanged: (value) => loginProvider.password = value,
              validator: (value) {
                return (value != null && value.length >= 8)
                    ? null
                    : 'Debe tener minimo 8 caracteres';
              },
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Recuperar contraseña",
              style: TextStyle(
                  color: Color.fromRGBO(228, 36, 36, .7),
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 60,
              minWidth: double.infinity,
              color: const Color.fromRGBO(228, 36, 36, .7),
              onPressed: loginProvider.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginProvider.isValidForm()) return;

                      loginProvider.isLoading = true;

                      final String? errorMessage = await authService.login(
                          loginProvider.email, loginProvider.password);

                      if (errorMessage == null) {
                        // ignore: use_build_context_synchronously
                        Navigator.pushReplacementNamed(context, MyRoutes.rHome);
                      }
                    },
              child: const Text(
                "Iniciar",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
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
