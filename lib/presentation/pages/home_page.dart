import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../data/services/firebase_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseService service = FirebaseService();
  final TextEditingController descC = TextEditingController();

  uploadImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;

    await service.uploadPost(File(image.path),
        FirebaseAuth.instance.currentUser!.email!, descC.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Photo Social App"),
        actions: [
          IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => FirebaseAuth.instance.signOut())
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: descC,
            decoration: const InputDecoration(hintText: "Description"),
          ),
          ElevatedButton(
              onPressed: uploadImage, child: const Text("Upload Photo")),
          Expanded(
            child: StreamBuilder(
              stream: service.fetchPosts(),
              builder: (_, snapshot) {
                if (!snapshot.hasData)
                  return const Center(child: CircularProgressIndicator());

                final docs = snapshot.data!.docs;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: docs.length,
                  itemBuilder: (_, i) =>
                      Image.network(docs[i]['imageUrl'], fit: BoxFit.cover),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
