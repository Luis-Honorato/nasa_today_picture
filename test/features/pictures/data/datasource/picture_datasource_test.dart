import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:nasa_today_picture/features/pictures/data/datasource/picture_datasource.dart';

import 'picture_datasource_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late final MockClient mockClient;
  late final PictureDatasource datasource;

  setUp(() {
    mockClient = MockClient();
    datasource = PictureDatasource(client: mockClient);
  });

  test('Must return a json when call getPictures method', () async {
    const fakeJson = [
      {
        "date": "2024-05-26",
        "explanation":
            "What's happened to our Sun?  Nothing very unusual -- it just threw a filament. Toward the middle of 2012, a long standing solar filament suddenly erupted into space, producing an energetic coronal mass ejection (CME).  The filament had been held up for days by the Sun's ever changing magnetic field and the timing of the eruption was unexpected. Watched closely by the Sun-orbiting Solar Dynamics Observatory, the resulting explosion shot electrons and ions into the Solar System, some of which arrived at Earth three days later and impacted Earth's magnetosphere, causing visible auroras. Loops of plasma surrounding the active region can be seen above the erupting filament in the featured ultraviolet image. Our Sun is nearing the most active time in its 11-year cycle, creating many coronal holes that allow for the ejection of charged particles into space. As before, these charged particles can create auroras.    Your Sky Surprise: What picture did APOD feature on your birthday? (post 1995)",
        "hdurl": "https://apod.nasa.gov/apod/image/2405/filament_sdo_1080.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "A Solar Filament Erupts",
        "url": "https://apod.nasa.gov/apod/image/2405/filament_sdo_960.jpg"
      },
      {
        "copyright": "Amiel Contuliano",
        "date": "2024-05-27",
        "explanation":
            "Dark markings and bright nebulae in this telescopic southern sky view are telltale signs of young stars and active star formation. They lie a mere 650 light-years away, at the boundary of the local bubble and the Chamaeleon molecular cloud complex. Regions with young stars identified as dusty reflection nebulae from the 1946 Cederblad catalog include the C-shaped Ced 110 just above and right of center, and bluish Ced 111 below it. Also a standout in the frame, the orange tinted V-shape of the Chamaeleon Infrared Nebula (Cha IRN) was carved by material streaming from a newly formed low-mass star.  The well-composed image spans 1.5 degrees. That's about 17 light-years at the estimated distance of the nearby Chamaeleon I molecular cloud.",
        "hdurl": "https://apod.nasa.gov/apod/image/2405/Cederblad111-110.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Chamaeleon I Molecular Cloud",
        "url": "https://apod.nasa.gov/apod/image/2405/Cederblad111-110_1024.jpg"
      },
    ];

    final fakeResponse = http.Response(fakeJson.toString(), 200);

    when(mockClient.get(any))
        .thenAnswer((realInvocation) async => fakeResponse);

    final response = await datasource.getPictures(startDate: '');

    expect(response, equals(fakeResponse));
  });
}
