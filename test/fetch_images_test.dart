import 'package:livingwallpaper/models/image.dart';
import 'package:livingwallpaper/services/api.dart';
import 'package:livingwallpaper/views/utils/constants.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  String url =
      "https://pixabay.com/api/?key=${ConstantUtils.key}&image_type=photo&orientation=vertical&page=1";

  group('Fetch Images', () {
    // use Mockito to return dummyData
    test('return images if the http call completes successfully', () async {
      final client = MockClient();
      final dummyData = '{"total":323824, "totalHits":500, "hits":[]}';
      when(client.get(url))
          .thenAnswer((_) async => http.Response(dummyData, 200));
      expect(await ApiService.getAllImages(client: client),
          const TypeMatcher<List<Image>>());
    });

    test('throws an exception if the http call completes with an error', () {
      final client = MockClient();
      // Use Mockito to return an unsuccessful response when it calls the
      // provided http.Client.
      when(client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(ApiService.getAllImages(client: client), throwsException);
    });
  });

  //This checks if the Api server returns images..... Note: It requires internet connection
  test('Fetch Images from the server', () async {
    final result = await ApiService.getAllImages();
    expect(result[0], TypeMatcher<Image>());
  });
}
