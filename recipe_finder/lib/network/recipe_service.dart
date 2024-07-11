
import 'package:http/http.dart';

const String apiKey = '5ef4701b027d0500456fa2eaa28324a1';
const String apiId = '0d380136';
const baseUrl = 'api.edamam.com';
const searchApi = '/api/recipes/v2';

Future getData(Uri url) async {
  print('Calling url: $url');

  final response = await get(url);
  if (response.statusCode == 200) {
    return response.body;
  } else {
    print(response.statusCode);
  }
}

class RecipeService {
  Future<dynamic> getRecipes(String query, int from, int to) async {
    final url = Uri.https(baseUrl, searchApi, {'app_id': apiId, 'app_key': apiKey, 'type': 'public', 'q': query, 'from': '$from', 'to': '$to'});
    final recipeData = await getData(url);
    return recipeData;
  }
}