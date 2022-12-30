import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:walkcity/src/preferences/preferences.dart';

class StorageImageProvider extends ChangeNotifier {
  File? image;
  String? nameImage;

  //BD
  String urlbase = 'https://kowzlncfrrqjcojxapmv.supabase.co/rest/v1/DatosUsuario';
  String keydb =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';
  String autorization =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ';

  //SUPABASE STORAGE
  final SupabaseClient client = SupabaseClient(
    'https://kowzlncfrrqjcojxapmv.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imtvd3psbmNmcnJxamNvanhhcG12Iiwicm9sZSI6ImFub24iLCJpYXQiOjE2NzEwNjgzMDQsImV4cCI6MTk4NjY0NDMwNH0.uyGGT_QVwemGWQY-IEsIVPuEC0itGhQ19l4sjJkc1gQ',
  );

  //=======================================================
  //API

  Future<String> guardarDB(String? from) async {
    final url = Uri.parse('$urlbase?usuario=eq.${Preferences.identificador}');
    final String msg;

    Map<String, String> header = {
      'apikey': keydb,
      'Authorization': autorization,
      'Content-Type': 'application/json',
      'Prefer': 'return=minimal'
    };

    final body = jsonEncode({
      "nombre": Preferences.name,
      "edad": Preferences.years,
      "origen": from,
      "image": nameImage
    });

    final response = await http.patch(url, body: body, headers: header);

    if (response.statusCode != 204) {
      msg = 'MSG=> NO SE GUARDO CORRECTAMENTE';
    } else {
      msg = 'MSG=> SE GUARDO CORRECTAMENTE';
      subirImageStorage();
    }
    return msg;
  }

  //=======================================================

  //SUBIR LA IMAGE A STORAGE
  Future subirImageStorage() async {
    final file = File(image!.path);

    final ruta0 = '/data/user/0/com.example.demo1/cache/$nameImage';
    final ruta1 = image!.path.replaceAll(
      'data/user/0/com.example.demo1/cache',
      'IMG',
    );

    final ruta2 = image!.path.replaceAll(
      'data/user/0/com.example.demo1/app_flutter',
      'IMG',
    );

    final newPath = (image!.path == ruta0) ? ruta1 : ruta2;

    await client.storage.from('profile.images').upload(newPath, file);

    notifyListeners();
  }

  //GALERIA
  Future activeGalleryImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    nameImage = image.name;
    this.image = imageTemp;
    notifyListeners();
  }
}