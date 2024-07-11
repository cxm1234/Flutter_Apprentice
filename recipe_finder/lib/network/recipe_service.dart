import 'dart:core';
import 'package:chopper/chopper.dart';
import 'recipe_model.dart';
import 'model_response.dart';
import 'model_converter.dart';

part 'recipe_service.chopper.dart';

const String apiKey = '5ef4701b027d0500456fa2eaa28324a1';
const String apiId = '0d380136';
const baseUrl = 'api.edamam.com';
const searchPath = '/api/recipes/v2';

@ChopperApi()
abstract class RecipeService extends ChopperService {
  @Get(path: searchPath)
  Future<Response<Result<APIRecipeQuery>>> queryRecipes(@Query('app_id') String app_id, @Query('app_key') String app_key, @Query('type') String type, @Query('q') String query, @Query('from') int from, @Query('to') int to);
  static RecipeService create() {
    final url = Uri.https(baseUrl);
    final client = ChopperClient(
      baseUrl: url,
      interceptors: [HttpLoggingInterceptor()],
      converter: ModelConverter(),
      errorConverter: const JsonConverter(),
      services: [
        _$RecipeService(),
      ]
    );
    return _$RecipeService(client);
  }
}
//
// Request _addQuery(Request req) {
//   final params = Map<String, dynamic>.from(req.parameters);
//   params['app_id'] = apiId;
//   params['app_key'] = apiKey;
//   params['type'] = 'public';
//   return req.copyWith(parameters: params);
// }