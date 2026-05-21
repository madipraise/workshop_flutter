import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const _base =
      'https://jsonplaceholder.typicode.com';

  Future<List<Post>> fetchPosts() async {
    try {
      final res = await http
          .get(Uri.parse('$_base/posts'))
          .timeout(const Duration(seconds: 10));

      if (res.statusCode == 200) {
        final list = jsonDecode(res.body) as List;
        return list
            .map((j) => Post.fromJson(j))
            .toList();
      }
      throw Exception('HTTP ${res.statusCode}');
    } catch (e) {
      throw Exception('Reseau: $e');
    }
  }
}

// models/post.dart
class Post {
  final int id;
  final String title, body;
  const Post({required this.id,
    required this.title, required this.body});

  factory Post.fromJson(Map<String, dynamic> j) =>
      Post(id: j['id'], title: j['title'],
           body: j['body']);
}