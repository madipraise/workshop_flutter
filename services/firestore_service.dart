import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final _db = FirebaseFirestore.instance;
  String get _uid =>
      FirebaseAuth.instance.currentUser!.uid;

  // Stream temps reel des taches
  Stream<QuerySnapshot> getTasksStream() =>
      _db.collection('tasks')
         .where('userId', isEqualTo: _uid)
         .orderBy('createdAt', descending: true)
         .snapshots();

  Future<void> addTask(String title) =>
      _db.collection('tasks').add({
        'title':     title,
        'done':      false,
        'userId':    _uid,
        'createdAt': FieldValue.serverTimestamp(),
      });

  Future<void> deleteTask(String id) =>
      _db.collection('tasks').doc(id).delete();

  Future<void> toggleTask(String id, bool v) =>
      _db.collection('tasks')
         .doc(id)
         .update({'done': !v});
}