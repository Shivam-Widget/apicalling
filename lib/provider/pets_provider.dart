import 'package:apicalling/models/pets.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class PetsProvider extends ChangeNotifier {
  static const apiEndPoint =
      'https://jatinderji.github.io/users_pets_api/users_pets.json';

  bool isLoading = true;
  String error = '';
  Pets pets = Pets(data: []);

  getDataFromApi() async {
    try {
      Response res = await http.get(Uri.parse(apiEndPoint));

      if (res.statusCode == 200) {
        pets = petsFromJson(res.body);
      } else {
        error = res.statusCode.toString();
      }
    } catch (e) {
      error = e.toString();
    }

    isLoading = false;

    notifyListeners();


  }
}
