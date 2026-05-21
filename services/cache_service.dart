import 'package:hive_flutter/hive_flutter.dart';

class CacheService {
  static const _boxName = 'posts_cache';
  static const _maxAge = Duration(minutes: 30);

  Box get _box => Hive.box(_boxName);

  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox(_boxName);
  }

  // Stocker les posts
  Future<void> cachePosts(List<Post> posts) async {
    await _box.put('posts', posts.map((p) =>
        {'id':p.id,'title':p.title,'body':p.body})
        .toList());
    await _box.put('cached_at',
        DateTime.now().toIso8601String());
  }

  // Lire le cache
  List<Post>? getCachedPosts() {
    final raw = _box.get('posts');
    if (raw == null) return null;
    return (raw as List).map((m) =>
        Post.fromJson(Map<String, dynamic>.from(m)))
        .toList();
  }

  bool get isFresh {
    final ts = _box.get('cached_at');
    if (ts == null) return false;
    return DateTime.now()
        .difference(DateTime.parse(ts)) < _maxAge;
  }
}