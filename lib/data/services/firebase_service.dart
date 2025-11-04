import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/post_model.dart';

class FirebaseService {
  final _firestore = FirebaseFirestore.instance;
  final _storage = FirebaseStorage.instance;

  Future<void> uploadPost(File file, String email, String description) async {
    final fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final ref = _storage.ref().child("posts/$fileName.jpg");

    await ref.putFile(file);
    final url = await ref.getDownloadURL();

    final post =
        Post(imageUrl: url, userEmail: email, description: description);
    await _firestore.collection('posts').add(post.toJson());
  }

  Stream<QuerySnapshot> fetchPosts() =>
      _firestore.collection('posts').orderBy("imageUrl").snapshots();
}
