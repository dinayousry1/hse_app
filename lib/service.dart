import 'package:dio/dio.dart';
import 'package:hse_app/product.dart';

class Services {
  late Dio dio;

  Services() {
    dio = Dio();
    dio.options.baseUrl = 'https://be-test.dev.qaraservices.net';
    dio.options.headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'appname': 'HSE-KSA',
    };
  }

  Future<Product?> scanQRCode(String qr) async {
    print("product.qrCode.value : ${qr}");
    try {
      final response = await dio.post(
        '/scan/publicScan?qrCode=${qr}',
      );

      print('Response data: ${response.data}');

      if (response.statusCode == 201) {
        PublicScanModel publicScanModel =
            PublicScanModel.fromJson(response.data);

        if (publicScanModel.body![0].products!.isNotEmpty) {
          return publicScanModel.body![0].products!.first;
        } else {
          print('Product is not original or product data is unavailable.');
          return null;
        }
      } else {
        print('Failed to scan QR code: ${response.statusCode}');
        return null;
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 409) {
        print(
            'Conflict: The request could not be completed due to a conflict.');
        print('Response data: ${e.response?.data}');
      } else {
        print('Error scanning QR code: $e');
      }
    } catch (e) {
      print('Unexpected error: $e');
    }
    return null;
  }
}
