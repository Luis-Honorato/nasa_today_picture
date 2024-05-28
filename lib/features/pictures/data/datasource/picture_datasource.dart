import 'package:http/http.dart' as http;
import 'package:nasa_today_picture/api_keys.dart';

class PictureDatasource {
  final http.Client client;

  PictureDatasource({required this.client});

  Future<http.Response> getPictures({required String startDate}) async {
    /// Request response from api
    final response =
        await client.get(Uri.parse('${ApiKeys.apiURl}&start_date=$startDate'));

    return response;
  }
}
