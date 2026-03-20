import 'package:http/http.dart' as http;
void main(List<String> args) {
    fetchPost();  
}

fetchPost() async{
    var uri = Uri.http('domain', '/path');
    final response = await http.get(uri);
    print(response);
}
