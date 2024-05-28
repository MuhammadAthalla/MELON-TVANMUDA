import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends StatefulWidget {
  static String routeName = 'create_page';
  const CreatePage({Key? key}) : super(key: key);

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final TextEditingController _titleController = TextEditingController();
  HtmlEditorController controller = HtmlEditorController();
  CollectionReference _articles =
      FirebaseFirestore.instance.collection("articles");
  String? imageUrl; // Updated to allow null value

  void _addArticle(String title, String detail, String? imageUrl) {
    if (title.isNotEmpty && detail.isNotEmpty && imageUrl != null) {
      _articles.add({'title': title, 'detail': detail, 'image': imageUrl});
      _titleController.clear();
      controller.clear();
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Artikel berhasil ditambahkan")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Mohon lengkapi semua kolom")),
      );
    }
  }

  Future<void> _uploadImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gambar tidak dipilih")),
      );
      return;
    }

    String uniqueFileName = DateTime.now().millisecondsSinceEpoch.toString();

    Reference referenceRoot = FirebaseStorage.instance.ref();
    Reference referenceDirImage = referenceRoot.child('image');
    Reference referenceImageToUpload = referenceDirImage.child(uniqueFileName);

    try {
      await referenceImageToUpload.putFile(File(file.path));
      imageUrl = await referenceImageToUpload.getDownloadURL();
      setState(() {}); // Update tampilan untuk menampilkan gambar yang diunggah
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengunggah gambar")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Tambah Data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(hintText: "Title"),
              ),
              SizedBox(height: 22),
              HtmlEditor(
                controller: controller,
                htmlToolbarOptions:
                    HtmlToolbarOptions(toolbarType: ToolbarType.nativeGrid),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadImage,
                child: Text("Pilih Gambar"),
              ),
              SizedBox(height: 10),
              if (imageUrl != null)
                Image.network(
                  imageUrl!,
                  width: 100,
                  height: 100,
                ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  String title = _titleController.text.trim();
                  String detail = await controller.getText();
                  _addArticle(title, detail, imageUrl);
                },
                child: Text("Simpan Data"),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
