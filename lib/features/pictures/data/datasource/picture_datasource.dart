import 'package:http/http.dart' as http;
import 'package:nasa_today_picture/api_keys.dart';

class PictureDatasource {
  final http.Client client;

  PictureDatasource({required this.client});

  Future<http.Response> getPictures({DateTime? startDate}) async {
    /// Create a default value of StartDate when is null
    late String startDateString;
    if (startDate == null) {
      final dateDifference = DateTime.now().subtract(const Duration(days: 7));
      startDateString =
          '${dateDifference.year}-${dateDifference.month}-${dateDifference.day}';
    } else {
      startDateString = '${startDate.year}-${startDate.month}-${startDate.day}';
    }

    /// Request response from api
    final response = await client
        .get(Uri.parse('${ApiKeys.apiURl}&start_date=$startDateString'));

    return response;
  }
}
