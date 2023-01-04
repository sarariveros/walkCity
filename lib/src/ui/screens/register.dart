import 'package:flutter/material.dart';
import 'package:walkcity/src/providers/provider_login.dart';
import 'package:walkcity/src/routes/routes.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/services/service_auth.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/widgets/index.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          final FocusScopeNode focus = FocusScope.of(context);
          if (!focus.hasPrimaryFocus && focus.hasFocus) {
            FocusManager.instance.primaryFocus!.unfocus();
          }
        },
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: -20,
                left: -10,
                width: 200,
                height: 200,
                child: Image.asset("assets/shape_01.png"),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        "Bienvenido a WalkCity!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.w600),
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
                      ChangeNotifierProvider(
                        create: (context) => ProviderLogin(),
                        child: _LoginForm(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Text(
                            "¿Ya tienes una cuenta?",
                          ),
                          MaterialButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, MyRoutes.rLogin);
                            },
                            child: Text(
                              "Inicia sesion",
                              style: TextStyle(
                                  color: Styles.firstColor,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  @override
  State<_LoginForm> createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
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
              keyboardType: TextInputType.text,
              decoration: Styles.buildDecoration(
                hintText: 'Ingresa tu nombre',
              ),
              onChanged: (value) => loginProvider.name = value,
              validator: (value) {
                return (value != null && value.isNotEmpty)
                    ? null
                    : 'Esta vacio';
              },
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              style: const TextStyle(color: Colors.black),
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: Styles.buildDecoration(
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
              keyboardType: TextInputType.text,
              decoration: Styles.buildDecoration(
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
            TextFormField(
              style: const TextStyle(color: Colors.black),
              autocorrect: false,
              keyboardType: TextInputType.text,
              decoration: Styles.buildDecoration(
                hintText: 'Confirma tu contraseña',
              ),
              validator: (value) {
                return (value != null && loginProvider.password == value)
                    ? null
                    : 'Las contraseñas no coinciden';
              },
            ),
            const SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 60,
              minWidth: double.infinity,
              color: Styles.firstColor,
              onPressed: loginProvider.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();

                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginProvider.isValidForm()) return;

                      loginProvider.isLoading = true;

                      final String? errorMessage = await authService.createUser(
                          loginProvider.email,
                          loginProvider.password,
                          loginProvider.name);

                      if (errorMessage == null) {
                        // ignore: use_build_context_synchronously
                        AlertDialogD.showAlertDialog(
                            context,
                            'EXITO',
                            'Confirma tu correo en tu email e inicia sesion',
                            true,
                            true,
                            MyRoutes.rLogin,
                            "Iniciar secion");
                      } else {
                        // ignore: use_build_context_synchronously
                        AlertDialogD.showAlertDialog(context, 'ERROR',
                            'Vuelve a intentarlo', false, false, '', "Volver");
                      }
                      loginProvider.isLoading = false;
                    },
              child: const Text(
                "Registrarse",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
