
import 'api_request.dart';
import 'model.dart';


class PostsProvider {
  void getPostsList({
    Function() beforeSend,
    Function(List<Products> posts) onSuccess,
    Function(dynamic error) onError,
  }) {
    ApiRequest(url: 'https://jsonplaceholder.typicode.com/photos', data: null).get(
      beforeSend: () => {if (beforeSend != null) beforeSend()},
      onSuccess: (data) {
        onSuccess((data as List).map((postJson) => Products.fromJson(postJson)).toList());
      },
      onError: (error) => {if (onError != null) onError(error)},
    );
  }
}