import 'package:bizcard_app/network/api_client.dart';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageService {

  Future<dynamic> uploadImage({required CroppedFile file, required String cardId, bool loader = true})async{
    ApiClient client = ApiClient('/card-image?cardId=$cardId', loader: loader);
    var img = await details(file);
    var multipart = MultipartFile.fromBytes(img['bytes'], filename: img['name'], contentType: MediaType ('image', img['ext']));
    var data = {'file': multipart};
    var formData = FormData.fromMap(data);
    return await client.post(formData);
  }

  details(CroppedFile file)async{
    return {
      'bytes': await file.readAsBytes(),
      'name': file.path.split('/').last,
      'ext': file.path.split('.').last
    };
  }

}