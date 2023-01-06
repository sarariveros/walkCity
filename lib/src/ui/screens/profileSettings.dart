import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:walkcity/src/preferences/preferences.dart';
import 'package:walkcity/src/providers/storage_provider.dart';
import 'package:walkcity/src/resources/countries.dart';
import 'package:walkcity/src/routes/routes.dart';
import 'package:walkcity/src/styles/style.dart';
import 'package:walkcity/src/ui/widgets/index.dart';

class ProfileSettingPage extends StatelessWidget {
  const ProfileSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final storageProvider = Provider.of<StorageImageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Editar perfil'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                    color: Styles.firstColor,
                  ),
                  child: (storageProvider.image != null)
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: SizedBox.fromSize(
                            size: const Size.fromRadius(48),
                            child: Image.file(
                              storageProvider.image!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : const Icon(
                          Icons.photo,
                          size: 100,
                        ),
                ),
                onTap: () {
                  storageProvider.activeGalleryImage();
                },
              ),
              _FormData()
            ],
          ),
        ),
      ),
    );
  }
}

class _FormData extends StatefulWidget {
  @override
  State<_FormData> createState() => __FormDataState();
}

class __FormDataState extends State<_FormData> {
  __FormDataState() {
    _selectVal = listCountries[0]["name"];
  }

  String? _selectVal = "";

  @override
  Widget build(BuildContext context) {
    final storageProvider = Provider.of<StorageImageProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        child: Form(
          child: Column(
            children: [
              TextFormField(
                style: const TextStyle(color: Colors.black),
                autocorrect: false,
                keyboardType: TextInputType.emailAddress,
                decoration: Styles.buildDecoration(
                  hintText: 'Nombre',
                ),
                initialValue: Preferences.name,
                onChanged: (value) => Preferences.name = value,
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                style: const TextStyle(color: Colors.black),
                autocorrect: false,
                keyboardType: TextInputType.text,
                decoration: Styles.buildDecoration(
                  hintText: 'Edad',
                ),
                initialValue: Preferences.years,
                onChanged: (value) => Preferences.years = value,
              ),
              const SizedBox(
                height: 20,
              ),
              DropdownButtonFormField(
                value: _selectVal,
                isExpanded: true,
                items: listCountries.map((itemVal) {
                  return DropdownMenuItem(
                    value: itemVal["name"],
                    child: Text(itemVal["name"]),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectVal = value.toString();
                  });
                },
                decoration: Styles.buildDecoration(),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 150,
                height: 50,
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  color: Styles.firstColor,
                  onPressed: () async {
                    final message = await storageProvider.guardarDB(_selectVal);

                    if (message == "MSG=> SE GUARDO CORRECTAMENTE") {
                      // ignore: use_build_context_synchronously
                      AlertDialogD.showAlertDialog(
                          context,
                          "EXITO",
                          "Se actualizo exitosamente",
                          true,
                          true,
                          MyRoutes.rHome,
                          "Volver");
                    } else {
                      // ignore: use_build_context_synchronously
                      AlertDialogD.showAlertDialog(context, "ERROR",
                          "Intentalo nuevamente", false, false, "", "Volver");
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      Icon(Icons.save),
                      Text('Guardar'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
