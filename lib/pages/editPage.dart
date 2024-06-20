import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

class EditPage extends StatefulWidget {
  final String articleId;
  final String initialTitle;
  final String initialDetail;
  final String? imageUrl;
  static String routeName = 'edit_page';

  const EditPage({
    Key? key,
    required this.articleId,
    required this.initialTitle,
    required this.initialDetail,
    this.imageUrl,
  }) : super(key: key);

  @override
  _EditPageState createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  late TextEditingController _titleController;
  late TextEditingController _detailController;
  HtmlEditorController _htmlEditorController = HtmlEditorController();
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _detailController = TextEditingController(text: widget.initialDetail);
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String?> _uploadImage(File imageFile) async {
    try {
      final storageRef =
          FirebaseStorage.instance.ref().child('articles/${widget.articleId}');
      final uploadTask = storageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() => null);
      final downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print('Failed to upload image: $e');
      return null;
    }
  }

  Future<void> _updateArticle() async {
    if (_titleController.text.isEmpty || _detailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Title and Detail cannot be empty')),
      );
      return;
    }

    String? imageUrl = widget.imageUrl;
    if (_imageFile != null) {
      imageUrl = await _uploadImage(_imageFile!);
    }

    try {
      await FirebaseFirestore.instance
          .collection('articles')
          .doc(widget.articleId)
          .update({
        'title': _titleController.text,
        'detail': _detailController.text,
        'image': imageUrl,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Article updated successfully')),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update article: $e')),
      );
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Article', style: GoogleFonts.poppins()),
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
              style: GoogleFonts.poppins(),
            ),
            SizedBox(height: 16),
            HtmlEditor(
              controller: _htmlEditorController,
              htmlEditorOptions: HtmlEditorOptions(
                hint: "Edit Artikel",
                initialText: widget.initialDetail,
              ),
            ),
            SizedBox(height: 10),
            Center(
              child: _imageFile != null
                  ? Image.file(_imageFile!, height: 80)
                  : widget.imageUrl != null
                      ? Image.network(widget.imageUrl!, height: 80)
                      : Text('No image selected'),
            ),
            Spacer(),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _pickImage,
                    child: Text('Pilih Gambar', style: GoogleFonts.poppins()),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  ElevatedButton(
                    onPressed: _updateArticle,
                    child:
                        Text('Simpan Perubahan', style: GoogleFonts.poppins()),
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
